class LeaveBalanceModel {
  final String leaveType;
  final double availableDays;
  final double totalDays;
  final String description;

  LeaveBalanceModel({
    required this.leaveType,
    required this.availableDays,
    required this.totalDays,
    required this.description,
  });

  factory LeaveBalanceModel.fromJson(Map<String, dynamic> json) {
    return LeaveBalanceModel(
      leaveType: json['leaveType'] ?? '',
      availableDays: (json['availableDays'] ?? 0).toDouble(),
      totalDays: (json['totalDays'] ?? 0).toDouble(),
      description: json['description'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'leaveType': leaveType,
      'availableDays': availableDays,
      'totalDays': totalDays,
      'description': description,
    };
  }

  String get formattedAvailableDays => availableDays.toStringAsFixed(1);
}

class LeaveRequestModel {
  final String id;
  final String leaveType;
  final DateTime startDate;
  final DateTime endDate;
  final String reason;
  final String status;
  final DateTime appliedDate;
  final double totalDays;
  final String? approverComments;

  LeaveRequestModel({
    required this.id,
    required this.leaveType,
    required this.startDate,
    required this.endDate,
    required this.reason,
    required this.status,
    required this.appliedDate,
    required this.totalDays,
    this.approverComments,
  });

  factory LeaveRequestModel.fromJson(Map<String, dynamic> json) {
    return LeaveRequestModel(
      id: json['id'] ?? '',
      leaveType: json['leaveType'] ?? '',
      startDate: DateTime.parse(json['startDate'] ?? ''),
      endDate: DateTime.parse(json['endDate'] ?? ''),
      reason: json['reason'] ?? '',
      status: json['status'] ?? '',
      appliedDate: DateTime.parse(json['appliedDate'] ?? ''),
      totalDays: (json['totalDays'] ?? 0).toDouble(),
      approverComments: json['approverComments'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'leaveType': leaveType,
      'startDate': startDate.toIso8601String(),
      'endDate': endDate.toIso8601String(),
      'reason': reason,
      'status': status,
      'appliedDate': appliedDate.toIso8601String(),
      'totalDays': totalDays,
      'approverComments': approverComments,
    };
  }

  String get formattedDateRange {
    final startFormat = _formatDate(startDate);
    final endFormat = _formatDate(endDate);
    return '$startFormat - $endFormat';
  }

  String get formattedAppliedDate => _formatDate(appliedDate);
  String get formattedTotalDays => totalDays == 1.0 ? '1 day' : '${totalDays.toStringAsFixed(1)} days';

  static String _formatDate(DateTime date) {
    const List<String> months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    return '${date.day} ${months[date.month - 1]} ${date.year}';
  }
}

class LeaveApplyResponse {
  final bool success;
  final String message;
  final LeaveRequestModel? leaveRequest;

  LeaveApplyResponse({
    required this.success,
    required this.message,
    this.leaveRequest,
  });

  factory LeaveApplyResponse.fromJson(Map<String, dynamic> json) {
    return LeaveApplyResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      leaveRequest: json['leaveRequest'] != null
          ? LeaveRequestModel.fromJson(json['leaveRequest'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      'leaveRequest': leaveRequest?.toJson(),
    };
  }
}

class LeaveBalanceResponse {
  final bool success;
  final String message;
  final List<LeaveBalanceModel> leaveBalances;

  LeaveBalanceResponse({
    required this.success,
    required this.message,
    required this.leaveBalances,
  });

  factory LeaveBalanceResponse.fromJson(Map<String, dynamic> json) {
    return LeaveBalanceResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      leaveBalances: (json['leaveBalances'] as List?)
              ?.map((item) => LeaveBalanceModel.fromJson(item))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      'leaveBalances': leaveBalances.map((balance) => balance.toJson()).toList(),
    };
  }

  double get totalAvailableBalance {
    return leaveBalances.fold(0.0, (sum, balance) => sum + balance.availableDays);
  }
}
