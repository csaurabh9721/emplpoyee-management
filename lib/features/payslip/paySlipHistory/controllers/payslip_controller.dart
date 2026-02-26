import 'package:get/get.dart';
import '../../../../core/Enums/enums.dart';
import '../../../../core/utils/base_api_response.dart';
import '../models/payslip_models.dart';
import '../services/payslip_service.dart';

class PayslipController extends GetxController {
  final PayslipService _payslipService = PayslipService();

  BaseApiResponse<PayslipHistoryResponse> payslipHistoryData = BaseApiResponse.loading();
  BaseApiResponse<PayslipHistoryResponse> archivedPayslipsData = BaseApiResponse.loading();
  
  // Current selected payslip for detailed view
  Rx<PayslipModel?> selectedPayslip = Rx<PayslipModel?>(null);
  
  // Tab selection (0 for Recent, 1 for Archive)
  RxInt selectedTab = 0.obs;

  @override
  void onInit() {
    super.onInit();
    _loadPayslipHistory();
  }

  Future<void> _loadPayslipHistory() async {
    try {
      payslipHistoryData = BaseApiResponse.loading();
      update();
      final PayslipHistoryResponse data = await _payslipService.getPayslipHistory();
      payslipHistoryData = BaseApiResponse.success(data: data);
      update();
    } catch (e) {
      payslipHistoryData = BaseApiResponse.error(e.toString());
      update();
    }
  }

  Future<void> loadArchivedPayslips() async {
    try {
      archivedPayslipsData = BaseApiResponse.loading();
      update();
      final PayslipHistoryResponse data = await _payslipService.getArchivedPayslips();
      archivedPayslipsData = BaseApiResponse.success(data: data);
      update();
    } catch (e) {
      archivedPayslipsData = BaseApiResponse.error(e.toString());
      update();
    }
  }

  Future<void> refreshPayslipData() async {
    if (selectedTab.value == 0) {
      await _loadPayslipHistory();
    } else {
      await loadArchivedPayslips();
    }
  }

  Future<void> selectPayslip(String payslipId) async {
    try {
      selectedPayslip.value = null;
      update();
      final PayslipModel? payslip = await _payslipService.getPayslipById(payslipId);
      selectedPayslip.value = payslip;
      update();
    } catch (e) {
      selectedPayslip.value = null;
      update();
    }
  }

  void changeTab(int index) {
    selectedTab.value = index;
    update();
    
    // Load archived data when switching to archive tab
    //if (index == 1 && archivedPayslipsData.status == ApiStatus.idle) {
      loadArchivedPayslips();
    //}
  }

  // Getters for computed properties
  bool get isLoading => 
      (selectedTab.value == 0 && payslipHistoryData.status == ApiStatus.loading) ||
      (selectedTab.value == 1 && archivedPayslipsData.status == ApiStatus.loading);
      
  bool get hasError => 
      (selectedTab.value == 0 && payslipHistoryData.status == ApiStatus.error) ||
      (selectedTab.value == 1 && archivedPayslipsData.status == ApiStatus.error);
      
  bool get hasData => 
      (selectedTab.value == 0 && payslipHistoryData.status == ApiStatus.completed) ||
      (selectedTab.value == 1 && archivedPayslipsData.status == ApiStatus.completed);
  
  String get errorMessage => 
      selectedTab.value == 0 ? payslipHistoryData.message : archivedPayslipsData.message;
  
  List<PayslipModel> get currentPayslips {
    if (selectedTab.value == 0) {
      return payslipHistoryData.data?.payslips ?? [];
    } else {
      return archivedPayslipsData.data?.payslips ?? [];
    }
  }

  PayslipModel? get currentMonthPayslip {
    final payslips = payslipHistoryData.data?.payslips ?? [];
    return payslips.isNotEmpty ? payslips.first : null;
  }

  // Helper methods
  void clearError() {
    if (hasError) {
      if (selectedTab.value == 0) {
        payslipHistoryData = BaseApiResponse.loading();
      } else {
        archivedPayslipsData = BaseApiResponse.loading();
      }
      update();
    }
  }

  void clearSelectedPayslip() {
    selectedPayslip.value = null;
    update();
  }
}
