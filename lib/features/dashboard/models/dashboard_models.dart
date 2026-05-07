import 'package:clientone_ess/core/utils/date_formatter.dart';
import 'package:flutter/material.dart';

import '../../../core/routes/routes_name.dart';

class DashboardDataModel {
  final int statusCode;
  final String message;
  final DashboardDataModelBody body;

  DashboardDataModel({
    required this.statusCode,
    required this.message,
    required this.body,
  });

  factory DashboardDataModel.fromJson(Map<String, dynamic> json) =>
      DashboardDataModel(
        statusCode: json["statusCode"] ?? 0,
        message: json["message"] ?? "Something went wrong",
        body: DashboardDataModelBody.fromJson(json["body"]),
      );
}

class DashboardDataModelBody {
  final int employeeId;
  final int organizationId;
  final int officeId;
  final String employeeName;
  final String designationName;
  final String image;
  final TodayAttendance todayAttendance;
  final List<AnnouncementModel> announcements;
  final List<QuickActionModel> quickActions;

  DashboardDataModelBody({
    required this.employeeId,
    required this.organizationId,
    required this.officeId,
    required this.employeeName,
    required this.designationName,
    required this.image,
    required this.todayAttendance,
    required this.announcements,
    required this.quickActions,
  });

  factory DashboardDataModelBody.fromJson(Map<String, dynamic> json) =>
      DashboardDataModelBody(
        employeeId: json["employeeId"] ?? 0,
        organizationId: json["organizationId"] ?? 0,
        officeId: json["officeId"] ?? 0,
        employeeName: json["employeeName"] ?? "",
        designationName: json["designationName"] ?? "",
        image: json["image"] ?? "",
        todayAttendance: TodayAttendance.fromJson(json["todayAttendance"]),
        announcements: [
          AnnouncementModel(
            id: "1",
            title: "Annual Town Hall Meeting",
            description:
                "Join us this Friday for the annual town hall meeting...",
            date: "Oct 20, 2024",
            type: "COMPANY UPDATE",
          ),
          AnnouncementModel(
            id: "2",
            title: "New Health Insurance Options",
            description:
                "We have updated our health insurance provider list...",
            date: "Oct 18, 2024",
            type: "BENEFITS",
          ),
        ],
        quickActions: [
          QuickActionModel(
            id: "2",
            title: "Team Attendance",
            icon: "team_attendance",
            route: RoutesName.teamAttendance,
          ),
          QuickActionModel(
            id: "3",
            title: "Balance",
            icon: "balance",
            route: RoutesName.accountBalance,
          ),
          QuickActionModel(
            id: "4",
            title: "Leave Management",
            icon: "leave",
            route: RoutesName.leaveManagementPage,
          ),
          QuickActionModel(
            id: "5",
            title: "Leave Approval",
            icon: "approval",
            route: RoutesName.leaveApproval,
          ),
          QuickActionModel(
            id: "6",
            title: "View Payslip",
            icon: "payslip",
            route: RoutesName.payslipHistory,
          ),

          QuickActionModel(
            id: "8",
            title: "Holiday",
            icon: "holiday",
            route: RoutesName.holidayScreen,
          ),

          // QuickActionModel(
          //   id: "1",
          //   title: "Attendance",
          //   icon: "attendance",
          //   route: RoutesName.attendance,
          // ),
          // QuickActionModel(
          //   id: "7",
          //   title: "Profile",
          //   icon: "profile",
          //   route: RoutesName.profile,
          // ),
        ],
      );

  @override
  String toString() {
    return 'DashboardDataModelBody{employeeId: $employeeId, organizationId: $organizationId, officeId: $officeId, employeeName: $employeeName, designationName: $designationName, image: $image, todayAttendance: $todayAttendance, announcements: $announcements, quickActions: $quickActions}';
  }
}

class TodayAttendance {
  final DateTime attendanceDate;
  final DateTime? punchInTime;
  final DateTime? punchOutTime;
  final String workHour;

  TodayAttendance({
    required this.attendanceDate,
    required this.punchInTime,
    required this.punchOutTime,
    required this.workHour,
  });

  factory TodayAttendance.fromJson(Map<String, dynamic> json) =>
      TodayAttendance(
        attendanceDate:
            DateTime.tryParse(json["attendanceDate"] ?? "") ?? DateTime.now(),
        punchInTime: DateTime.tryParse(json["punchInTime"] ?? ""),
        punchOutTime: DateTime.tryParse(json["punchOutTime"] ?? ""),
        workHour:
            json["workHour"] != null && json["workHour"].toString().isNotEmpty
                ? json["workHour"]
                : "--:--",
      );

  String get getFormattedDate => attendanceDate.ddMmYyyy();

  String get getFormattedPunchInTime => punchInTime?.to12HourTime() ?? "";

  String get getFormattedPunchOutTime => punchOutTime?.to12HourTime() ?? "";

  Color get getContainerColor {
    if (workHour == "--:--") {
      return Colors.indigo.shade50;
    }
    int hours = 0;
    int minutes = 0;
    final hourMatch = RegExp(r'(\d+)h').firstMatch(workHour);
    if (hourMatch != null) {
      hours = int.parse(hourMatch.group(1)!);
    }
    final minuteMatch = RegExp(r'(\d+)m').firstMatch(workHour);
    if (minuteMatch != null) {
      minutes = int.parse(minuteMatch.group(1)!);
    }
    final int totalMinutes = hours * 60 + minutes;
    if (totalMinutes >= 8 * 60) {
      return Colors.green.shade100;
    } else {
      return Colors.red.shade100;
    }
  }

  String get getButtonText {
    if (punchInTime != null && punchOutTime != null) {
      return "Punch Out";
    } else if (punchInTime != null && punchOutTime == null) {
      return "Punch Out";
    } else if (punchInTime == null && punchOutTime == null) {
      return "Punch In";
    } else {
      return "Punch In";
    }
  }
}

class AnnouncementModel {
  final String id;
  final String title;
  final String description;
  final String date;
  final String type;

  AnnouncementModel({
    required this.id,
    required this.title,
    required this.description,
    required this.date,
    required this.type,
  });

  factory AnnouncementModel.fromJson(Map<String, dynamic> json) {
    return AnnouncementModel(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      date: json['date'] ?? '',
      type: json['type'] ?? '',
    );
  }
}

class QuickActionModel {
  final String id;
  final String title;
  final String icon;
  final String route;

  QuickActionModel({
    required this.id,
    required this.title,
    required this.icon,
    required this.route,
  });

  factory QuickActionModel.fromJson(Map<String, dynamic> json) {
    return QuickActionModel(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      icon: json['icon'] ?? '',
      route: json['route'] ?? '',
    );
  }
}
