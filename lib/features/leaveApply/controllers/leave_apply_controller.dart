import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../leaveManagementPage/models/leave_models.dart';
import '../models/leave_apply_models.dart';
import '../services/leave_apply_service.dart';
import '../services/get_leave_type.dart';

class LeaveApplyController extends GetxController {
  // Form data
  final TextEditingController reasonController = TextEditingController();
  final TextEditingController startDateController = TextEditingController();
  final TextEditingController endDateController = TextEditingController();

  Rx<DateTime?> startDate = Rx<DateTime?>(null);
  Rx<DateTime?> endDate = Rx<DateTime?>(null);

  RxList<String> leaveTypes = <String>[].obs;
  final List<LeaveBalanceModel> leaveBalances = Get.arguments;
  late Rx<LeaveBalanceModel> selectedLeaveBalance;
  RxString selectedLeaveType = ''.obs;

  RxBool isLoading = false.obs;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();



  @override
  void onInit() {
    super.onInit();
    selectedLeaveBalance = leaveBalances.first.obs;
    _fetchLeaveTypes();
  }

  Future<void> _fetchLeaveTypes() async {
    try {
      leaveTypes.value = await GetLeaveTypeService().fetchLeaveTypes();
      _setInitialLeaveBalance();
    } catch (e) {
      debugPrint("Error fetching leave types: $e");
    }
  }

  void _setInitialLeaveBalance() {
    selectedLeaveType.value = leaveTypes.firstWhere((e) => e == "CL", orElse: () => leaveTypes.first);
    selectedLeaveBalance.value = leaveBalances.firstWhere((e) => e.type == selectedLeaveType.value);
  }

  Future<void> applyLeave() async {
    if (!formKey.currentState!.validate()) return;
    final validationMessage = validateForm();
    if (validationMessage != null) {
      Get.snackbar(
        'Validation Error',
        validationMessage,
        backgroundColor: Colors.orange,
        colorText: Colors.white,
        duration: const Duration(seconds: 2),
      );
      return;
    }
    try {
      isLoading.value = true;
      final LeaveApplyResponse response = await LeaveApplyService().applyLeave(
        leaveType: selectedLeaveType.value,
        startDate: startDate.value!,
        endDate: endDate.value!,
        reason: reasonController.text,
      );
      Get.back();
      Get.snackbar(
        'Success',
        "Leave request submitted successfully",
        backgroundColor: Colors.green,
        colorText: Colors.white,
        duration: const Duration(seconds: 3),
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        e.toString(),
        backgroundColor: Colors.red,
        colorText: Colors.white,
        duration: const Duration(seconds: 3),
      );
    } finally {
      isLoading.value = false;
    }
  }
  String? validateForm() {
    if (startDate.value == null || endDate.value == null) {
      return "Please select leave dates";
    }
    final start = startDate.value!;
    final end = endDate.value!;
    if (start.isBefore(DateTime.now().subtract(const Duration(days: 1)))) {
      return "You cannot apply leave for past dates";
    }
    if (end.isBefore(start)) {
      return "End date cannot be before start date";
    }
    if (reasonController.text.trim().isEmpty) {
      return "Please enter reason";
    }
    if (reasonController.text.trim().length < 5) {
      return "Reason must be at least 5 characters";
    }
    final totalDays = end.difference(start).inDays + 1;
    if (totalDays > selectedLeaveBalance.value.availableDays) {
      return "Insufficient ${selectedLeaveBalance.value.type} balance";
    }
    return null; // valid
  }
}
