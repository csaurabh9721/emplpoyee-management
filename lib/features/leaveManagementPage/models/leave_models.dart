import 'package:flutter/material.dart';

class LeaveBalanceModel {
  final String type;
  final int totalDays;
  final int usedDays;
  final int availableDays;
  final String icon;
  final Color color;

  LeaveBalanceModel({
    required this.type,
    required this.totalDays,
    required this.usedDays,
    required this.availableDays,
    required this.icon,
    required this.color,
  });

  factory LeaveBalanceModel.fromJson(Map<String, dynamic> json) {
    return LeaveBalanceModel(
      type: json['type'] ?? '',
      totalDays: json['totalDays'] ?? 0,
      usedDays: json['usedDays'] ?? 0,
      availableDays: json['availableDays'] ?? 0,
      icon: json['icon'] ?? '',
      color: _getColorFromString(json['color'] ?? 'grey'),
    );
  }

  static Color _getColorFromString(String colorString) {
    switch (colorString.toLowerCase()) {
      case 'indigo':
        return Colors.indigo;
      case 'green':
        return Colors.green;
      case 'orange':
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }
}

class LeaveRequestModel {
  final String id;
  final String type;
  final String startDate;
  final String endDate;
  final int days;
  final String status;
  final String reason;
  final DateTime appliedDate;

  LeaveRequestModel({
    required this.id,
    required this.type,
    required this.startDate,
    required this.endDate,
    required this.days,
    required this.status,
    required this.reason,
    required this.appliedDate,
  });

  factory LeaveRequestModel.fromJson(Map<String, dynamic> json) {
    return LeaveRequestModel(
      id: json['id'] ?? '',
      type: json['type'] ?? '',
      startDate: json['startDate'] ?? '',
      endDate: json['endDate'] ?? '',
      days: json['days'] ?? 0,
      status: json['status'] ?? '',
      reason: json['reason'] ?? '',
      appliedDate: DateTime.parse(json['appliedDate'] ?? DateTime.now().toIso8601String()),
    );
  }

  String get formattedDateRange {
    if (days == 1) {
      return startDate;
    } else {
      return '$startDate - $endDate';
    }
  }

  String get formattedDateWithDays {
    final dateRange = formattedDateRange;
    return '$dateRange ($days day${days > 1 ? 's' : ''})';
  }

  Color get statusColor {
    switch (status.toUpperCase()) {
      case 'PENDING':
        return Colors.orange;
      case 'APPROVED':
        return Colors.green;
      case 'REJECTED':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}

class LeaveManagementDataModel {
  final List<LeaveBalanceModel> leaveBalances;
  final List<LeaveRequestModel> recentRequests;

  LeaveManagementDataModel({
    required this.leaveBalances,
    required this.recentRequests,
  });

  factory LeaveManagementDataModel.fromJson(Map<String, dynamic> json) {
    return LeaveManagementDataModel(
      leaveBalances: (json['leaveBalances'] as List?)
          ?.map((item) => LeaveBalanceModel.fromJson(item))
          .toList() ?? [],
      recentRequests: (json['recentRequests'] as List?)
          ?.map((item) => LeaveRequestModel.fromJson(item))
          .toList() ?? [],
    );
  }
}
