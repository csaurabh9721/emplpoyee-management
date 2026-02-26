import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/Enums/enums.dart';
import '../../../../core/utils/base_api_response.dart';
import '../models/leave_apply_models.dart';
import '../services/leave_apply_service.dart';

class LeaveApplyController extends GetxController {
  final LeaveApplyService _leaveApplyService = LeaveApplyService();

  // Form data
  RxString selectedLeaveType = ''.obs;
  Rx<DateTimeRange?> selectedDateRange = Rx<DateTimeRange?>(null);
  RxString reason = ''.obs;

  // API responses
  BaseApiResponse<LeaveBalanceResponse> leaveBalanceData = BaseApiResponse.loading();
  BaseApiResponse<LeaveApplyResponse> applyLeaveData = BaseApiResponse.initial();

  // Form validation
  bool get isFormValid => 
      selectedLeaveType.value.isNotEmpty &&
      selectedDateRange.value != null &&
      reason.value.isNotEmpty;

  // Leave types for dropdown
  List<String> get leaveTypes => 
      leaveBalanceData.data?.leaveBalances.map((balance) => balance.leaveType).toList() ?? ['Annual Leave', 'Sick Leave', 'Casual Leave', 'Unpaid Leave'];

  @override
  void onInit() {
    super.onInit();
    _loadLeaveBalances();
  }

  Future<void> _loadLeaveBalances() async {
    try {
      leaveBalanceData = BaseApiResponse.loading();
      update();
      final LeaveBalanceResponse data = await _leaveApplyService.getLeaveBalances();
      leaveBalanceData = BaseApiResponse.success(data: data);
      update();
    } catch (e) {
      leaveBalanceData = BaseApiResponse.error(e.toString());
      update();
    }
  }

  Future<void> applyLeave() async {
    if (!isFormValid) {
      Get.snackbar(
        'Validation Error',
        'Please fill all required fields',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        duration: const Duration(seconds: 2),
      );
      return;
    }

    try {
      applyLeaveData = BaseApiResponse.loading();
      update();

      final LeaveApplyResponse response = await _leaveApplyService.applyLeave(
        leaveType: selectedLeaveType.value,
        startDate: selectedDateRange.value!.start,
        endDate: selectedDateRange.value!.end,
        reason: reason.value,
      );

      applyLeaveData = BaseApiResponse.success(data: response);
      update();

      if (response.success) {
        // Show success message
        Get.snackbar(
          'Success',
          response.message,
          backgroundColor: Colors.green,
          colorText: Colors.white,
          duration: const Duration(seconds: 3),
        );

        // Clear form
        _clearForm();

        // Go back to leave management page
        Future.delayed(const Duration(seconds: 2), () {
          Get.back();
        });
      } else {
        // Show error message
        Get.snackbar(
          'Error',
          response.message,
          backgroundColor: Colors.red,
          colorText: Colors.white,
          duration: const Duration(seconds: 3),
        );
      }
    } catch (e) {
      applyLeaveData = BaseApiResponse.error(e.toString());
      update();

      Get.snackbar(
        'Error',
        'Failed to submit leave request',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        duration: const Duration(seconds: 2),
      );
    }
  }

  void _clearForm() {
    selectedLeaveType.value = '';
    selectedDateRange.value = null;
    reason.value = '';
    applyLeaveData = BaseApiResponse.initial();
    update();
  }

  void selectLeaveType(String leaveType) {
    selectedLeaveType.value = leaveType;
    update();
  }

  void selectDateRange(DateTimeRange? dateRange) {
    selectedDateRange.value = dateRange;
    update();
  }

  void updateReason(String newReason) {
    reason.value = newReason;
    update();
  }

  // Getters for computed properties
  bool get isLoading => leaveBalanceData.status == ApiStatus.loading;
  bool get hasError => leaveBalanceData.status == ApiStatus.error;
  bool get hasData => leaveBalanceData.status == ApiStatus.completed;
  bool get isSubmitting => applyLeaveData.status == ApiStatus.loading;

  String get errorMessage => leaveBalanceData.message;
  String get submitMessage => applyLeaveData.message;

  List<LeaveBalanceModel> get leaveBalances => 
      leaveBalanceData.data?.leaveBalances ?? [];

  double get totalAvailableBalance => 
      leaveBalanceData.data?.totalAvailableBalance ?? 0.0;

  LeaveBalanceModel? getBalanceForType(String leaveType) {
    try {
      return leaveBalances.firstWhere((balance) => balance.leaveType == leaveType);
    } catch (e) {
      return null;
    }
  }

  double getAvailableDaysForType(String leaveType) {
    final balance = getBalanceForType(leaveType);
    return balance?.availableDays ?? 0.0;
  }

  String get formattedTotalBalance => totalAvailableBalance.toStringAsFixed(1);

  // Date formatting
  String formatDate(DateTime date) {
    const List<String> months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    return '${date.day} ${months[date.month - 1]} ${date.year}';
  }

  String get formattedDateRange {
    if (selectedDateRange.value == null) return 'Select date range';
    
    final start = formatDate(selectedDateRange.value!.start);
    final end = formatDate(selectedDateRange.value!.end);
    return '$start - $end';
  }

  double get calculatedLeaveDays {
    if (selectedDateRange.value == null) return 0.0;
    return _leaveApplyService.calculateLeaveDays(
      selectedDateRange.value!.start,
      selectedDateRange.value!.end,
    );
  }

  String get formattedLeaveDays {
    final days = calculatedLeaveDays;
    return days == 1.0 ? '1 day' : '${days.toStringAsFixed(1)} days';
  }

  bool get hasSufficientBalance {
    if (selectedLeaveType.value.isEmpty || selectedDateRange.value == null) {
      return true; // Don't show warning until form is filled
    }

    // Unpaid leave doesn't require balance
    if (selectedLeaveType.value == 'Unpaid Leave') {
      return true;
    }

    final availableDays = getAvailableDaysForType(selectedLeaveType.value);
    return calculatedLeaveDays <= availableDays;
  }

  String get balanceWarningMessage {
    if (hasSufficientBalance) return '';
    
    final availableDays = getAvailableDaysForType(selectedLeaveType.value);
    return 'Insufficient balance. Available: ${availableDays.toStringAsFixed(1)} days';
  }

  // Helper methods
  void clearError() {
    if (hasError) {
      leaveBalanceData = BaseApiResponse.loading();
      update();
    }
  }

  void refreshBalances() {
    _loadLeaveBalances();
  }

  void goBack() {
    Get.back();
  }

  // Validation helpers
  bool isValidDateRange(DateTimeRange? range) {
    if (range == null) return false;
    
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final startDate = DateTime(range.start.year, range.start.month, range.start.day);
    
    // Don't allow dates in the past
    return !startDate.isBefore(today);
  }

  String? validateLeaveType(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please select a leave type';
    }
    return null;
  }

  String? validateDateRange(DateTimeRange? value) {
    if (value == null) {
      return 'Please select date range';
    }
    
    if (!isValidDateRange(value)) {
      return 'Cannot select past dates';
    }
    
    return null;
  }

  String? validateReason(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please provide a reason';
    }
    
    if (value.length < 10) {
      return 'Reason must be at least 10 characters';
    }
    
    return null;
  }
}
