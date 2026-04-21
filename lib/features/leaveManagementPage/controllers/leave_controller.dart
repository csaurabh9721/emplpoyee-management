import 'package:get/get.dart';
import '../../../core/Enums/enums.dart';
import '../../../core/utils/base_api_response.dart';
import '../models/leave_models.dart';
import '../services/leave_service.dart';

class LeaveController extends GetxController {
  final LeaveService _leaveService = LeaveService();

  BaseApiResponse<List<LeaveBalanceModel>> leaveData = BaseApiResponse.loading();
  BaseApiResponse<List<LeaveResponseModel>> leaveRequests = BaseApiResponse.loading();

  @override
  void onInit() {
    super.onInit();
    _loadAllData();
  }

  Future<void> _loadAllData() async {
    await Future.wait([
      _loadLeaveData(),
      _loadLeaveRequests(),
    ]);
  }

  Future<void> _loadLeaveData() async {
    try {
      leaveData = BaseApiResponse.loading();
      update();
      final List<LeaveBalanceModel> data = await _leaveService.getLeaveManagementData();
      leaveData = BaseApiResponse.success(data: data);
      update();
    } catch (e) {
      leaveData = BaseApiResponse.error(e.toString());
      update();
    }
  }

  Future<void> _loadLeaveRequests() async {
    try {
      leaveRequests = BaseApiResponse.loading();
      update();
      final List<LeaveResponseModel> data = await _leaveService.getAllLeaveRequests();
      leaveRequests = BaseApiResponse.success(data: data);
      update();
    } catch (e) {
      leaveRequests = BaseApiResponse.error(e.toString());
      update();
    }
  }

  Future<void> refreshLeaveData() async {
    await _loadAllData();
  }

  // Getters for computed properties
  bool get isLoading => leaveData.status == ApiStatus.loading || leaveRequests.status == ApiStatus.loading;

  bool get hasError => leaveData.status == ApiStatus.error || leaveRequests.status == ApiStatus.error;

  bool get hasData => leaveData.status == ApiStatus.completed && leaveRequests.status == ApiStatus.completed;

  String get errorMessage => leaveData.message.isNotEmpty ? leaveData.message : leaveRequests.message;

  List<LeaveBalanceModel> get leaveBalances => leaveData.data ?? [];

  List<LeaveResponseModel> get recentRequests => (leaveRequests.data ?? []).take(3).toList();

  // Helper methods
  LeaveBalanceModel? getAnnualBalance() {
    return leaveBalances.firstWhereOrNull((balance) => balance.type == 'Annual');
  }

  LeaveBalanceModel? getSickBalance() {
    return leaveBalances.firstWhereOrNull((balance) => balance.type == 'Sick');
  }

  LeaveBalanceModel? getPersonalBalance() {
    return leaveBalances.firstWhereOrNull((balance) => balance.type == 'Personal');
  }
}
