import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/Enums/enums.dart';
import '../../../../core/utils/base_api_response.dart';
import '../models/payslip_detail_models.dart';
import '../services/payslip_detail_service.dart';

class PayslipDetailController extends GetxController {
  final PayslipDetailService _payslipDetailService = PayslipDetailService();

  BaseApiResponse<PayslipDetailModel> payslipDetailData = BaseApiResponse.loading();
  
  // Get the payslip ID from arguments
  late String payslipId;

  @override
  void onInit() {
    super.onInit();
    // Get payslip ID from navigation arguments
    payslipId = Get.arguments as String? ?? '';
    if (payslipId.isNotEmpty) {
      _loadPayslipDetail();
    } else {
      payslipDetailData = BaseApiResponse.error('Payslip ID not provided');
      update();
    }
  }

  Future<void> _loadPayslipDetail() async {
    try {
      payslipDetailData = BaseApiResponse.loading();
      update();
      final PayslipDetailModel data = await _payslipDetailService.getPayslipDetail(payslipId);
      payslipDetailData = BaseApiResponse.success(data: data);
      update();
    } catch (e) {
      payslipDetailData = BaseApiResponse.error(e.toString());
      update();
    }
  }

  Future<void> refreshPayslipDetail() async {
    await _loadPayslipDetail();
  }

  // Getters for computed properties
  bool get isLoading => payslipDetailData.status == ApiStatus.loading;
  bool get hasError => payslipDetailData.status == ApiStatus.error;
  bool get hasData => payslipDetailData.status == ApiStatus.completed;
  
  String get errorMessage => payslipDetailData.message;
  
  PayslipDetailModel? get payslipDetail => payslipDetailData.data;

  // Helper methods to get formatted data
  String get employeeName => payslipDetail?.employeeName ?? 'N/A';
  String get employeeId => payslipDetail?.employeeId ?? 'N/A';
  String get department => payslipDetail?.department ?? 'N/A';
  String get designation => payslipDetail?.designation ?? 'N/A';
  String get displayMonth => payslipDetail?.displayMonth ?? 'N/A';
  String get payDate => payslipDetail?.payDate ?? 'N/A';
  String get status => payslipDetail?.status ?? 'N/A';
  
  // Work days information
  String get workDays => payslipDetail?.workDays ?? '0';
  String get leaveWithoutPay => payslipDetail?.leaveWithoutPay ?? '0';
  String get paidDays => payslipDetail?.paidDays ?? '0';
  
  // Salary components
  double get basicSalary => payslipDetail?.basicSalary ?? 0.0;
  double get hra => payslipDetail?.hra ?? 0.0;
  double get specialAllowance => payslipDetail?.specialAllowance ?? 0.0;
  double get conveyanceAllowance => payslipDetail?.conveyanceAllowance ?? 0.0;
  double get medicalAllowance => payslipDetail?.medicalAllowance ?? 0.0;
  double get otherAllowances => payslipDetail?.otherAllowances ?? 0.0;
  double get grossEarnings => payslipDetail?.grossEarnings ?? 0.0;
  
  // Deductions
  double get providentFund => payslipDetail?.providentFund ?? 0.0;
  double get professionalTax => payslipDetail?.professionalTax ?? 0.0;
  double get incomeTax => payslipDetail?.incomeTax ?? 0.0;
  double get otherDeductions => payslipDetail?.otherDeductions ?? 0.0;
  double get totalDeductions => payslipDetail?.totalDeductions ?? 0.0;
  double get netSalary => payslipDetail?.netSalary ?? 0.0;
  
  String get currency => payslipDetail?.currency ?? '\$';
  
  // Lists
  List<EarningItem> get earnings => payslipDetail?.earnings ?? [];
  List<DeductionItem> get deductions => payslipDetail?.deductions ?? [];

  // Formatted getters
  String get formattedBasicSalary => '$currency${basicSalary.toStringAsFixed(2)}';
  String get formattedHra => '$currency${hra.toStringAsFixed(2)}';
  String get formattedSpecialAllowance => '$currency${specialAllowance.toStringAsFixed(2)}';
  String get formattedConveyanceAllowance => '$currency${conveyanceAllowance.toStringAsFixed(2)}';
  String get formattedMedicalAllowance => '$currency${medicalAllowance.toStringAsFixed(2)}';
  String get formattedOtherAllowances => '$currency${otherAllowances.toStringAsFixed(2)}';
  String get formattedGrossEarnings => '$currency${grossEarnings.toStringAsFixed(2)}';
  String get formattedProvidentFund => '$currency${providentFund.toStringAsFixed(2)}';
  String get formattedProfessionalTax => '$currency${professionalTax.toStringAsFixed(2)}';
  String get formattedIncomeTax => '$currency${incomeTax.toStringAsFixed(2)}';
  String get formattedOtherDeductions => '$currency${otherDeductions.toStringAsFixed(2)}';
  String get formattedTotalDeductions => '$currency${totalDeductions.toStringAsFixed(2)}';
  String get formattedNetSalary => '$currency${netSalary.toStringAsFixed(2)}';

  // Status color
  Color get statusColor {
    switch (status.toUpperCase()) {
      case 'PAID':
        return Colors.green;
      case 'PENDING':
        return Colors.orange;
      case 'FAILED':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  // Helper methods
  void clearError() {
    if (hasError) {
      payslipDetailData = BaseApiResponse.loading();
      update();
    }
  }

  void goBack() {
    Get.back();
  }

  void downloadPayslip() {
    // TODO: Implement download functionality
    Get.snackbar(
      'Download',
      'Payslip download feature coming soon!',
      backgroundColor: Colors.indigo,
      colorText: Colors.white,
      duration: const Duration(seconds: 2),
    );
  }
}
