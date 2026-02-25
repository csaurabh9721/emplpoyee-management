import 'package:get/get.dart';
import '../../../core/Enums/enums.dart';
import '../../../core/utils/base_api_response.dart';
import '../models/leave_models.dart';
import '../services/leave_service.dart';

class LeaveController extends GetxController {
  final LeaveService _leaveService = LeaveService();

  BaseApiResponse<LeaveManagementDataModel> leaveData = BaseApiResponse.loading();

  @override
  void onInit() {
    super.onInit();
    _loadLeaveData();
  }

  Future<void> _loadLeaveData() async {
    try {
      leaveData = BaseApiResponse.loading();
      update();
      final LeaveManagementDataModel data = await _leaveService.getLeaveManagementData();
      leaveData = BaseApiResponse.success(data: data);
      update();
    } catch (e) {
      leaveData = BaseApiResponse.error(e.toString());
      update();
    }
  }

  Future<void> refreshLeaveData() async {
    await _loadLeaveData();
  }

  // Getters for computed properties
  bool get isLoading => leaveData.status == ApiStatus.loading;
  bool get hasError => leaveData.status == ApiStatus.error;
  bool get hasData => leaveData.status == ApiStatus.completed;
  
  String get errorMessage => leaveData.message;
  
  List<LeaveBalanceModel> get leaveBalances => 
      leaveData.data?.leaveBalances ?? [];
      
  List<LeaveRequestModel> get recentRequests => 
      leaveData.data?.recentRequests ?? [];

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

  void clearError() {
    if (hasError) {
      leaveData = BaseApiResponse.loading();
      update();
    }
  }
}
