import '../../../core/utils/date_formatter.dart';

class AttendanceModel {
  final int id;
  final int employeeId;
  final int organizationId;
  final DateTime attendanceDate;
  final DateTime? punchInTime;
  final DateTime? punchOutTime;
  final String workHour;

  AttendanceModel({
    required this.id,
    required this.employeeId,
    required this.organizationId,
    required this.attendanceDate,
    required this.punchInTime,
    required this.punchOutTime,
    required this.workHour,
  });

  factory AttendanceModel.fromJson(Map<String, dynamic> json) {
    return AttendanceModel(
      id: json['id'] ?? 0,
      employeeId: json['employeeId'] ?? 0,
      organizationId: json['organizationId'] ?? 0,
      attendanceDate: DateTime.tryParse(json["attendanceDate"] ?? "") ?? DateTime.now(),
      punchInTime: DateTime.tryParse(json["punchInTime"] ?? ""),
      punchOutTime: DateTime.tryParse(json["punchOutTime"] ?? ""),
      workHour: json["workHour"] != null && json["workHour"].toString().isNotEmpty ? json["workHour"] : "--:--",
    );
  }
  String get status => "Present";
  String get getFormattedDate => attendanceDate.ddMmYyyy();

  String get getFormattedPunchInTime => punchInTime?.to12HourTime() ?? "";

  String get getFormattedPunchOutTime => punchOutTime?.to12HourTime() ?? "";

}

class AttendanceData {
  final AttendanceModel? today;
  final List<AttendanceModel> history;

  AttendanceData({this.today, required this.history});
}
