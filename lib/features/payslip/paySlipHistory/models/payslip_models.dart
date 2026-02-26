class PayslipModel {
  final String id;
  final String month;
  final String year;
  final String payDate;
  final String status;
  final double grossPay;
  final double deductions;
  final double netPay;
  final String currency;

  PayslipModel({
    required this.id,
    required this.month,
    required this.year,
    required this.payDate,
    required this.status,
    required this.grossPay,
    required this.deductions,
    required this.netPay,
    this.currency = '\$',
  });

  factory PayslipModel.fromJson(Map<String, dynamic> json) {
    return PayslipModel(
      id: json['id'] ?? '',
      month: json['month'] ?? '',
      year: json['year'] ?? '',
      payDate: json['payDate'] ?? '',
      status: json['status'] ?? '',
      grossPay: (json['grossPay'] ?? 0).toDouble(),
      deductions: (json['deductions'] ?? 0).toDouble(),
      netPay: (json['netPay'] ?? 0).toDouble(),
      currency: json['currency'] ?? '\$',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'month': month,
      'year': year,
      'payDate': payDate,
      'status': status,
      'grossPay': grossPay,
      'deductions': deductions,
      'netPay': netPay,
      'currency': currency,
    };
  }

  String get displayMonth => '$month $year';
  String get formattedGrossPay => '$currency${grossPay.toStringAsFixed(2)}';
  String get formattedDeductions => '-$currency${deductions.toStringAsFixed(2)}';
  String get formattedNetPay => '$currency${netPay.toStringAsFixed(2)}';
}

class PayslipHistoryResponse {
  final List<PayslipModel> payslips;
  final String message;
  final bool success;

  PayslipHistoryResponse({
    required this.payslips,
    required this.message,
    required this.success,
  });

  factory PayslipHistoryResponse.fromJson(Map<String, dynamic> json) {
    return PayslipHistoryResponse(
      payslips: (json['payslips'] as List?)
              ?.map((item) => PayslipModel.fromJson(item))
              .toList() ??
          [],
      message: json['message'] ?? '',
      success: json['success'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'payslips': payslips.map((payslip) => payslip.toJson()).toList(),
      'message': message,
      'success': success,
    };
  }
}
