import '../../../core/utils/date_formatter.dart';

class TeamAttendanceModel {
  final DateTime? attendanceDate;
  final List<AttendanceList> attendanceList;

  TeamAttendanceModel({
    required this.attendanceDate,
    required this.attendanceList,
  });

  factory TeamAttendanceModel.fromJson(Map<String, dynamic> json) => TeamAttendanceModel(
        attendanceDate: DateTime.tryParse(json["attendanceDate"] ?? ""),
        attendanceList: json["attendanceList"] == null
            ? []
            : List<AttendanceList>.from(json["attendanceList"].map((x) => AttendanceList.fromJson(x))),
      );
}

class AttendanceList {
  final int id;
  final int employeeId;
  final String employeeName;
  final String avatar = "";

  ///todo get profile photo from backend
  final int organizationId;
  final DateTime? attendanceDate;
  final DateTime? punchInTime;
  final DateTime? punchOutTime;
  final String status;
  final String workHour;

  AttendanceList({
    required this.id,
    required this.employeeId,
    required this.employeeName,
    required this.organizationId,
    required this.attendanceDate,
    required this.punchInTime,
    required this.punchOutTime,
    required this.status,
    required this.workHour,
  });

  factory AttendanceList.fromJson(Map<String, dynamic> json) => AttendanceList(
        id: json["id"] ?? 0,
        employeeId: json["employeeId"] ?? 0,
        employeeName: json["employeeName"] ?? "",
        organizationId: json["organizationId"] ?? 0,
        attendanceDate: DateTime.tryParse(json["attendanceDate"] ?? ""),
        punchInTime: DateTime.tryParse(json["punchInTime"] ?? ""),
        punchOutTime: DateTime.tryParse(json["punchOutTime"] ?? ""),
        status: json["status"] ?? "",
        workHour: json["workHour"] ?? "--:--",
      );

  String get getCombine {
    if (punchInTime == null && punchOutTime == null) {
      return "";
    } else if (punchInTime != null && punchOutTime == null) {
      return "${punchInTime!.to12HourTime()} -";
    } else if (punchInTime != null && punchOutTime == null) {
      return "- ${punchOutTime!.to12HourTime()}";
    } else {
      return "${punchInTime!.to12HourTime()} - ${punchOutTime!.to12HourTime()}";
    }
  }
}
