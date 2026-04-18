class PunchInOutResponse {
  final int statusCode;
  final String message;
  final PunchInOutResponseBody body;

  PunchInOutResponse({
    required this.statusCode,
    required this.message,
    required this.body,
  });

  factory PunchInOutResponse.fromJson(Map<String, dynamic> json) => PunchInOutResponse(
    statusCode: json["statusCode"] ?? 0,
    message: json["message"] ?? "Something went wrong",
    body: PunchInOutResponseBody.fromJson(json["body"]),
  );

}

class PunchInOutResponseBody {
  final int id;
  final int employeeId;
  final int organizationId;
  final DateTime? attendanceDate;
  final DateTime? punchInTime;
  final DateTime? punchOutTime;
  final String workHour;

  PunchInOutResponseBody({
    required this.id,
    required this.employeeId,
    required this.organizationId,
    required this.attendanceDate,
    required this.punchInTime,
    required this.punchOutTime,
    required this.workHour,
  });

  factory PunchInOutResponseBody.fromJson(Map<String, dynamic> json) => PunchInOutResponseBody(
    id: json["id"] ?? 0,
    employeeId: json["employeeId"] ?? 0,
    organizationId: json["organizationId"] ?? 0,
    attendanceDate: DateTime.tryParse(json["attendanceDate"] ?? "") ?? DateTime.now(),
    punchInTime: DateTime.tryParse(json["punchInTime"] ?? ""),
    punchOutTime: DateTime.tryParse(json["punchOutTime"] ?? ""),
    workHour: json["workHour"] ?? "",
  );
}
