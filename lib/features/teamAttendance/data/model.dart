import '../domain/entity/entity.dart';

class TeamAttendanceResponse {

  TeamAttendanceResponse({
    required this.statusCode,
    required this.message,
    required this.entity,
  });

  factory TeamAttendanceResponse.fromJson(Map<String, dynamic> json) => TeamAttendanceResponse(
        statusCode: json["statuscode"] ?? 400,
        message: json["message"] ?? "Failed to load data",
        entity: json["entity"] == null ? null : Entity.fromJson(json["entity"]),
      );
  final int statusCode;
  final String message;
  final Entity? entity;

  List<TeamAttendanceEntity> get toEntity {
    final List<TeamAttendanceEntity> list = [];
    final Map<String, List<DateWiseBiometric>> attendance = {};
    for (BiometricDetail e in entity!.biometricDetail) {
      if (attendance.containsKey(e.attendanceDate)) {
        attendance[e.attendanceDate]!.add(e.toEntity);
      } else {
        attendance[e.attendanceDate] = [e.toEntity];
      }
    }
    for (MapEntry<String, List<DateWiseBiometric>> e in attendance.entries) {
      list.add(
          TeamAttendanceEntity(date: e.key, biometrics: e.value, weekDay: e.value.first.weekDay));
    }
    return list;
  }
}

class Entity {

  Entity({
    required this.biometricDetail,
  });

  factory Entity.fromJson(Map<String, dynamic> json) => Entity(
        biometricDetail: json["biometricdetail"] == null
            ? []
            : List<BiometricDetail>.from(
                json["biometricdetail"].map((x) => BiometricDetail.fromJson(x))),
      );
  final List<BiometricDetail> biometricDetail;
}

class BiometricDetail {

  BiometricDetail({
    required this.shortHours,
    required this.inTime,
    required this.weekday,
    required this.outTime,
    required this.penaltyDays,
    required this.employeeId,
    required this.attendanceDate,
    required this.leaveCode,
    required this.totalHoursWorked,
    required this.employeeCode,
    required this.penaltyRemarks,
    required this.attendanceStatus,
    required this.penaltyYn,
    required this.employeeName,
   // required this.userId,
    required this.tlyn,
  });

  factory BiometricDetail.fromJson(Map<String, dynamic> json) => BiometricDetail(
        shortHours: json["shorthours"] ?? "",
        inTime: json["intime"] ?? "",
        weekday: json["weekday"] ?? "",
        outTime: json["outtime"] ?? "",
        penaltyDays: json["penaltydays"] ?? 0,
        attendanceDate: json["attendancedate"] ?? "",
        leaveCode: json["leavecode"] ?? "",
        totalHoursWorked: json["totalhoursworked"] ?? "",
        employeeCode: json["employeecode"] ?? "",
        penaltyRemarks: json["penaltyremarks"] ?? "",
        attendanceStatus: json["attendancestatus"] ?? "",
        penaltyYn: json["penaltyyn"] ?? "",
        employeeName: json["employeename"] ?? "",
        employeeId: json["employeeid"] ?? "0000205",
       // userId: json["userid"] ?? "",
    tlyn: json["TLYN"] ?? "",
      );
  final String shortHours;
  final String inTime;
  final String weekday;
  final String outTime;
  final int penaltyDays;
  final String employeeId;
  final String attendanceDate;
  final String leaveCode;
  final String totalHoursWorked;
  final String employeeCode;
  final String penaltyRemarks;
  final String attendanceStatus;
  final String penaltyYn;
  final String employeeName;
 // final String userId;
  final String tlyn;

  DateWiseBiometric get toEntity {
    return DateWiseBiometric(
      name: employeeName,
      eCode: employeeCode,
      inTime: inTime,
      outTime: outTime,
      weekDay: weekday,
      role: tlyn == "Y" ? "TL" : "Emp",
      empId: employeeId,
   //   userId: userId,
    );
  }
}
