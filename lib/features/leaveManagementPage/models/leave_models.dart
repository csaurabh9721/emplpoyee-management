import 'package:clientone_ess/core/utils/date_formatter.dart';
import 'package:flutter/material.dart';

import '../../../core/utils/leave_utils.dart';

class LeaveBalanceModel {
  final int id;
  final String type;
  final int totalDays;
  final int usedDays;
  final int availableDays;
  final int year;
  final IconData icon;
  final Color color;
  final String leaveTypeFullName;

  LeaveBalanceModel({
    required this.id,
    required this.type,
    required this.totalDays,
    required this.usedDays,
    required this.availableDays,
    required this.year,
    required this.icon,
    required this.color,
    required this.leaveTypeFullName,
  });

  factory LeaveBalanceModel.fromJson(Map<String, dynamic> json) {
    return LeaveBalanceModel(
      id: json['id'] ?? 0,
      type: json['leaveType'] ?? '',
      totalDays: json['totalAllowed'] ?? 0,
      usedDays: json['used'] ?? 0,
      availableDays: json['remaining'] ?? 0,
      year: json['year'] ?? 0,
      icon: LeaveUtils.getIconFromString(json['leaveType'] ?? ""),
      color: LeaveUtils.getColorFromString(json['leaveType'] ?? ""),
      leaveTypeFullName: json['leaveTypeFullName'] ?? '',
    );
  }
}

class LeaveResponseModel {
  final int id;
  final String type;
  final DateTime? startDate;
  final DateTime? endDate;
  final int days;
  final String status;
  final String reason;
  final String employeeName;
  final String employeeCode;
  final DateTime? appliedAt;

  LeaveResponseModel({
    required this.id,
    required this.type,
    required this.startDate,
    required this.endDate,
    required this.days,
    required this.status,
    required this.reason,
    required this.employeeName,
    required this.employeeCode,
    required this.appliedAt,
  });

  factory LeaveResponseModel.fromJson(Map<String, dynamic> json) {
    return LeaveResponseModel(
      id: json['id'] ?? 0,
      type: json['leaveType'] ?? '',
      startDate: DateTime.tryParse(json['startDate'] ?? ''),
      endDate: DateTime.tryParse(json['endDate'] ?? ''),
      days: json['totalDays'] ?? 0,
      status: json['status'] ?? '',
      reason: json['reason'] ?? '',
      employeeName: json['employeeName'] ?? '',
      employeeCode: json['employeeCode'] ?? '',
      appliedAt: DateTime.tryParse(json['appliedAt'] ?? ''),
    );
  }

  String get formattedDateRange {
    if (days == 1) {
      return startDate?.ddMonthYYYY() ?? "";
    } else {
      return '${startDate?.ddMonthYYYY() ?? ""} - ${endDate?.ddMonthYYYY() ?? ""}';
    }
  }

  String get formattedDateWithDays {
    final dateRange = formattedDateRange;
    return '$dateRange ($days day${days > 1 ? 's' : ''})';
  }

  Color get statusColor {
    return LeaveUtils.statusColor(status);
  }
}
