import 'package:clientone_ess/core/utils/date_formatter.dart';

class LeaveRequestModel {
  final int employeeId;
  final String leaveType;
  final DateTime startDate;
  final DateTime endDate;
  final String reason;

  LeaveRequestModel({
    required this.employeeId,
    required this.leaveType,
    required this.startDate,
    required this.endDate,
    required this.reason,
  });

  Map<String, dynamic> toJson() {
    return {
      'employeeId': employeeId,
      'leaveType': leaveType,
      'startDate': startDate.yyyyMMDDDash(),
      'endDate': endDate.yyyyMMDDDash(),
      'reason': reason,
    };
  }
}

class LeaveApplyResponse {
  final int id;
  final int employeeId;
  final String employeeName;
  final String leaveType;
  final DateTime? startDate;
  final DateTime? endDate;
  final int totalDays;
  final String status;
  final String reason;
  final DateTime? appliedAt;
  final DateTime? actionedAt;

  LeaveApplyResponse({
    required this.id,
    required this.employeeId,
    required this.employeeName,
    required this.leaveType,
    required this.startDate,
    required this.endDate,
    required this.totalDays,
    required this.status,
    required this.reason,
    required this.appliedAt,
    required this.actionedAt,
  });

  factory LeaveApplyResponse.fromJson(Map<String, dynamic> json) => LeaveApplyResponse(
        id: json["id"] ?? 0,
        employeeId: json["employeeId"] ?? 0,
        employeeName: json["employeeName"] ?? '',
        leaveType: json["leaveType"] ?? '',
        startDate: DateTime.tryParse(json["startDate"] ?? ''),
        endDate: DateTime.tryParse(json["endDate"] ?? ''),
        totalDays: json["totalDays"] ?? 0,
        status: json["status"] ?? '',
        reason: json["reason"] ?? '',
        appliedAt: DateTime.tryParse(json["appliedAt"] ?? ''),
        actionedAt: DateTime.tryParse(json["actionedAt"] ?? ''),
      );
}
