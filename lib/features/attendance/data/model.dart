import 'package:flutter/material.dart';

import '../domain/attendance_entity.dart';

class GetSelfAttendanceResponse {

  GetSelfAttendanceResponse({
    required this.statusCode,
    required this.message,
    required this.entity,
  });

  factory GetSelfAttendanceResponse.fromJson(Map<String, dynamic> json) =>
      GetSelfAttendanceResponse(
        statusCode: json["statuscode"] ?? 400,
        message: json["message"] ?? "Failed to get data",
        entity: json["entity"] == null ? null : Entity.fromJson(json["entity"]),
      );
  final int statusCode;
  final String message;
  final Entity? entity;

  AttendanceEntity toEntity() {
    final List<BiometricDetailsEntity> biometricDetails =
        entity!.biometricDetail.map((e) => e.toEntity()).toList();
    return AttendanceEntity(
        biometricDetails: biometricDetails,
        attendanceSummary: entity!.summary.getAttendanceSummary);
  }
}

class Entity {

  Entity({
    required this.summary,
    required this.biometricDetail,
  });

  factory Entity.fromJson(Map<String, dynamic> json) => Entity(
        summary: json["summaryList"] == null
            ? Summary.copyWith()
            : Summary.fromJson(json["summaryList"]),
        biometricDetail: json["biometricdetail"] == null
            ? []
            : List<BiometricDetail>.from(
                json["biometricdetail"].map((x) => BiometricDetail.fromJson(x))),
      );
  final Summary summary;
  final List<BiometricDetail> biometricDetail;
}

class BiometricDetail {

  BiometricDetail({
    required this.shortHours,
    required this.inTime,
    required this.totalHoursWorked,
    required this.weekday,
    required this.outTime,
    required this.penaltyRemarks,
    required this.attendanceStatus,
    required this.penaltyDays,
    required this.penaltyYn,
    required this.attendanceDate,
    required this.leaveCode,
  });

  factory BiometricDetail.fromJson(Map<String, dynamic> json) => BiometricDetail(
        shortHours: json["shorthours"] ?? "",
        inTime: json["intime"] ?? "",
        totalHoursWorked: json["totalhoursworked"] ?? "",
        weekday: json["weekday"] ?? "",
        outTime: json["outtime"] ?? "",
        penaltyRemarks: json["penaltyremarks"] ?? "",
        attendanceStatus: json["attendancestatus"] ?? "",
        penaltyDays: json["penaltydays"] ?? 0,
        penaltyYn: json["penaltyyn"] ?? "",
        attendanceDate: json["attendancedate"] ?? "",
        leaveCode: json["leavecode"] ?? "",
      );
  final String shortHours;
  final String inTime;
  final String totalHoursWorked;
  final String weekday;
  final String outTime;
  final String penaltyRemarks;
  final String attendanceStatus;
  final int penaltyDays;
  final String penaltyYn;
  final String attendanceDate;
  final String leaveCode;

  BiometricDetailsEntity toEntity() {
    return BiometricDetailsEntity(
      date: attendanceDate,
      inTime: inTime,
      outTime: outTime,
      shortHour: shortHours,
      status: attendanceStatus,
      weekDay: weekday,
      description: penaltyRemarks,
      penaltyDays: penaltyDays,
      workingHours: totalHoursWorked,
    );
  }
}

class Summary {

  Summary({
    required this.weeklyOff,
    required this.biometricProcessYn,
    required this.employeeCode,
    required this.singlePunches,
    required this.notPunched,
    required this.outTimeViolations,
    required this.shortHoursViolations,
    required this.penaltyDays,
    required this.employeeId,
    required this.employeeName,
    required this.inTimeViolations,
  });

  factory Summary.fromJson(Map<String, dynamic> json) => Summary(
        weeklyOff: json["weeklyoff"] ?? 0,
        biometricProcessYn: json["biometricprocessyn"] ?? "",
        employeeCode: json["employeecode"] ?? "",
        singlePunches: json["singlepunches"] ?? 0,
        notPunched: json["notpunched"] ?? 0,
        outTimeViolations: json["outtimeviolations"] ?? 0,
        shortHoursViolations: json["shorthoursviolations"] ?? 0,
        penaltyDays: json["penaltydays"] ?? 0,
        employeeId: json["employeeid"] ?? "",
        employeeName: json["employeename"] ?? "",
        inTimeViolations: json["intimeviolations"] ?? 0,
      );

  factory Summary.copyWith() {
    return Summary(
      weeklyOff: 0,
      biometricProcessYn: "",
      employeeCode: "",
      singlePunches: 0,
      notPunched: 0,
      outTimeViolations: 0,
      shortHoursViolations: 0,
      penaltyDays: 0,
      employeeId: "",
      employeeName: "",
      inTimeViolations: 0,
    );
  }
  final int weeklyOff;
  final String biometricProcessYn;
  final String employeeCode;
  final int singlePunches;
  final int notPunched;
  final int outTimeViolations;
  final int shortHoursViolations;
  final int penaltyDays;
  final String employeeId;
  final String employeeName;
  final int inTimeViolations;

  List<AttendanceSummary> get getAttendanceSummary {
    final List<AttendanceSummary> attendanceSummary = [
      AttendanceSummary(
          icon: Icons.calendar_today,
          title: 'Weekly Off Holidays',
          value: weeklyOff.toString(),
          index: 1),
      AttendanceSummary(
          icon: Icons.cancel, title: 'Not Punch', value: notPunched.toString(), index: 2),
      AttendanceSummary(
          icon: Icons.watch_later,
          title: 'In Time Violations',
          value: inTimeViolations.toString(),
          index: 3),
      AttendanceSummary(
          icon: Icons.watch_later,
          title: 'Out Time Violations',
          value: outTimeViolations.toString(),
          index: 4),
      AttendanceSummary(
          icon: Icons.pending_actions,
          title: 'Penalty Days',
          value: penaltyDays.toString(),
          index: 5),
      AttendanceSummary(
          icon: Icons.punch_clock,
          title: 'Single Punch',
          value: singlePunches.toString(),
          index: 6),
      AttendanceSummary(
          icon: Icons.timelapse_rounded,
          title: 'Shorter Violations',
          value: shortHoursViolations.toString(),
          index: 7),
    ];
    return attendanceSummary;
  }
}
