class DashboardResponseModel {
  final int statusCode;
  final String message;
  final ResponseBody? body;

  DashboardResponseModel({
    required this.statusCode,
    required this.message,
    required this.body,
  });

  factory DashboardResponseModel.fromJson(Map<String, dynamic> json) {
    return DashboardResponseModel(
      statusCode: json["statuscode"] ?? 404,
      message: json["message"] ?? "Something went wrong",
      body: json["body"] != null ? ResponseBody.fromJson(json["body"]) : null,
    );
  }
}

class ResponseBody {
  final PunchInPunchOutResponseModel? punchTime;
  final List<PunchInPunchOutResponseModel> lastPunches;

  const ResponseBody({
    required this.punchTime,
    required this.lastPunches,
  });

  factory ResponseBody.fromJson(Map<String, dynamic> json) => ResponseBody(
        punchTime: PunchInPunchOutResponseModel.fromJson(json["punchTime"]),
        lastPunches: json["lastPunches"] != null
            ? List<PunchInPunchOutResponseModel>.from(
                json["lastPunches"].map((e) => PunchInPunchOutResponseModel.fromJson(e)))
            : [],
      );
}

final class PunchInPunchOutResponseModel {
  final String? punchInTime;
  final String? punchOutTime;

  const PunchInPunchOutResponseModel({
    required this.punchInTime,
    required this.punchOutTime,
  });

  factory PunchInPunchOutResponseModel.fromJson(Map<String, dynamic> json) => PunchInPunchOutResponseModel(
        punchInTime: json["punchInTime"],
        punchOutTime: json["punchOutTime"],
      );
}
