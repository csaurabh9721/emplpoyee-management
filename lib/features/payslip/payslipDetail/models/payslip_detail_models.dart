class PayslipDetailModel {
  final String id;
  final String month;
  final String year;
  final String payDate;
  final String status;
  final String employeeId;
  final String employeeName;
  final String department;
  final String designation;
  final String workDays;
  final String leaveWithoutPay;
  final String paidDays;
  final double basicSalary;
  final double hra;
  final double specialAllowance;
  final double conveyanceAllowance;
  final double medicalAllowance;
  final double otherAllowances;
  final double grossEarnings;
  final double providentFund;
  final double professionalTax;
  final double incomeTax;
  final double otherDeductions;
  final double totalDeductions;
  final double netSalary;
  final String currency;
  final List<EarningItem> earnings;
  final List<DeductionItem> deductions;

  PayslipDetailModel({
    required this.id,
    required this.month,
    required this.year,
    required this.payDate,
    required this.status,
    required this.employeeId,
    required this.employeeName,
    required this.department,
    required this.designation,
    required this.workDays,
    required this.leaveWithoutPay,
    required this.paidDays,
    required this.basicSalary,
    required this.hra,
    required this.specialAllowance,
    required this.conveyanceAllowance,
    required this.medicalAllowance,
    required this.otherAllowances,
    required this.grossEarnings,
    required this.providentFund,
    required this.professionalTax,
    required this.incomeTax,
    required this.otherDeductions,
    required this.totalDeductions,
    required this.netSalary,
    this.currency = '\$',
    required this.earnings,
    required this.deductions,
  });

  factory PayslipDetailModel.fromJson(Map<String, dynamic> json) {
    return PayslipDetailModel(
      id: json['id'] ?? '',
      month: json['month'] ?? '',
      year: json['year'] ?? '',
      payDate: json['payDate'] ?? '',
      status: json['status'] ?? '',
      employeeId: json['employeeId'] ?? '',
      employeeName: json['employeeName'] ?? '',
      department: json['department'] ?? '',
      designation: json['designation'] ?? '',
      workDays: json['workDays'] ?? '',
      leaveWithoutPay: json['leaveWithoutPay'] ?? '',
      paidDays: json['paidDays'] ?? '',
      basicSalary: (json['basicSalary'] ?? 0).toDouble(),
      hra: (json['hra'] ?? 0).toDouble(),
      specialAllowance: (json['specialAllowance'] ?? 0).toDouble(),
      conveyanceAllowance: (json['conveyanceAllowance'] ?? 0).toDouble(),
      medicalAllowance: (json['medicalAllowance'] ?? 0).toDouble(),
      otherAllowances: (json['otherAllowances'] ?? 0).toDouble(),
      grossEarnings: (json['grossEarnings'] ?? 0).toDouble(),
      providentFund: (json['providentFund'] ?? 0).toDouble(),
      professionalTax: (json['professionalTax'] ?? 0).toDouble(),
      incomeTax: (json['incomeTax'] ?? 0).toDouble(),
      otherDeductions: (json['otherDeductions'] ?? 0).toDouble(),
      totalDeductions: (json['totalDeductions'] ?? 0).toDouble(),
      netSalary: (json['netSalary'] ?? 0).toDouble(),
      currency: json['currency'] ?? '\$',
      earnings: (json['earnings'] as List?)
              ?.map((item) => EarningItem.fromJson(item))
              .toList() ??
          [],
      deductions: (json['deductions'] as List?)
              ?.map((item) => DeductionItem.fromJson(item))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'month': month,
      'year': year,
      'payDate': payDate,
      'status': status,
      'employeeId': employeeId,
      'employeeName': employeeName,
      'department': department,
      'designation': designation,
      'workDays': workDays,
      'leaveWithoutPay': leaveWithoutPay,
      'paidDays': paidDays,
      'basicSalary': basicSalary,
      'hra': hra,
      'specialAllowance': specialAllowance,
      'conveyanceAllowance': conveyanceAllowance,
      'medicalAllowance': medicalAllowance,
      'otherAllowances': otherAllowances,
      'grossEarnings': grossEarnings,
      'providentFund': providentFund,
      'professionalTax': professionalTax,
      'incomeTax': incomeTax,
      'otherDeductions': otherDeductions,
      'totalDeductions': totalDeductions,
      'netSalary': netSalary,
      'currency': currency,
      'earnings': earnings.map((item) => item.toJson()).toList(),
      'deductions': deductions.map((item) => item.toJson()).toList(),
    };
  }

  String get displayMonth => '$month $year';
  String get formattedBasicSalary => '$currency${basicSalary.toStringAsFixed(2)}';
  String get formattedHra => '$currency${hra.toStringAsFixed(2)}';
  String get formattedSpecialAllowance => '$currency${specialAllowance.toStringAsFixed(2)}';
  String get formattedGrossEarnings => '$currency${grossEarnings.toStringAsFixed(2)}';
  String get formattedTotalDeductions => '$currency${totalDeductions.toStringAsFixed(2)}';
  String get formattedNetSalary => '$currency${netSalary.toStringAsFixed(2)}';
}

class EarningItem {
  final String name;
  final double amount;
  final String description;

  EarningItem({
    required this.name,
    required this.amount,
    required this.description,
  });

  factory EarningItem.fromJson(Map<String, dynamic> json) {
    return EarningItem(
      name: json['name'] ?? '',
      amount: (json['amount'] ?? 0).toDouble(),
      description: json['description'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'amount': amount,
      'description': description,
    };
  }

  String get formattedAmount => '\$${amount.toStringAsFixed(2)}';
}

class DeductionItem {
  final String name;
  final double amount;
  final String description;

  DeductionItem({
    required this.name,
    required this.amount,
    required this.description,
  });

  factory DeductionItem.fromJson(Map<String, dynamic> json) {
    return DeductionItem(
      name: json['name'] ?? '',
      amount: (json['amount'] ?? 0).toDouble(),
      description: json['description'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'amount': amount,
      'description': description,
    };
  }

  String get formattedAmount => '-\$${amount.toStringAsFixed(2)}';
}
