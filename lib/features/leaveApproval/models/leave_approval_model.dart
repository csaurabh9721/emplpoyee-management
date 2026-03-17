class LeaveApprovalModel {
  final String id;
  final String employeeName;
  final String employeeId;
  final String leaveType;
  final DateTime startDate;
  final DateTime endDate;
  final String reason;
  final String status;
  final DateTime appliedDate;

  LeaveApprovalModel({
    required this.id,
    required this.employeeName,
    required this.employeeId,
    required this.leaveType,
    required this.startDate,
    required this.endDate,
    required this.reason,
    required this.status,
    required this.appliedDate,
  });

  factory LeaveApprovalModel.fromJson(Map<String, dynamic> json) {
    return LeaveApprovalModel(
      id: json['id'] ?? '',
      employeeName: json['employeeName'] ?? '',
      employeeId: json['employeeId'] ?? '',
      leaveType: json['leaveType'] ?? '',
      startDate: DateTime.parse(json['startDate']),
      endDate: DateTime.parse(json['endDate']),
      reason: json['reason'] ?? '',
      status: json['status'] ?? 'Pending',
      appliedDate: DateTime.parse(json['appliedDate']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'employeeName': employeeName,
      'employeeId': employeeId,
      'leaveType': leaveType,
      'startDate': startDate.toIso8601String(),
      'endDate': endDate.toIso8601String(),
      'reason': reason,
      'status': status,
      'appliedDate': appliedDate.toIso8601String(),
    };
  }

  int get totalDays => endDate.difference(startDate).inDays + 1;
}

class LeaveApprovalRequest {
  final String leaveId;
  final String status; // Approved or Rejected
  final String? remarks;

  LeaveApprovalRequest({
    required this.leaveId,
    required this.status,
    this.remarks,
  });

  Map<String, dynamic> toJson() {
    return {
      'leaveId': leaveId,
      'status': status,
      'remarks': remarks,
    };
  }
}
