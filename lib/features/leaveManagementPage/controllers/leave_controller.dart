import 'package:get/get.dart';
import '../models/leave_models.dart';
import '../services/leave_service.dart';

class LeaveController extends GetxController {
  final LeaveService _leaveService = LeaveService();

  RxList<LeaveBalanceModel> leaveBalances = <LeaveBalanceModel>[].obs;
  RxList<LeaveResponseModel> leaveRequests = <LeaveResponseModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    _loadAllData();
  }

  Future<void> _loadAllData() async {
    _loadLeaveData();
    _loadLeaveRequests();
  }

  Future<void> _loadLeaveData() async {
    try {
      leaveBalances.value = await _leaveService.getLeaveManagementData();
      update();
    } catch (e) {
      leaveBalances.value = [];
    }
  }

  Future<void> _loadLeaveRequests() async {
    try {
      leaveRequests.value = await _leaveService.getAllLeaveRequests();
    } catch (e) {
      leaveRequests.value = [];
    }
  }

  Future<void> refreshLeaveData() async {
    print("----------Refresh Data");
    await _loadAllData();
  }

  List<LeaveResponseModel> get recentRequests => leaveRequests.take(3).toList();
}
