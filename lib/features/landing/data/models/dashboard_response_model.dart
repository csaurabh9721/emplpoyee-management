import 'package:clientone_ess/features/landing/domain/entity/dashboard_response_entity.dart';

class DashboardResponseModel {
  DashboardResponseModel({
    required this.statusCode,
    required this.message,
    required this.entity,
    required this.latestPayslip,
    required this.todayStatus,
    required this.leaveBalance,
  });

  factory DashboardResponseModel.fromJson(Map<String, dynamic> json) {
    return DashboardResponseModel(
      statusCode: json["statuscode"],
      message: json["message"],
      entity: json["entity"] == null
          ? Entity(rights: [], parentRightsId: "")
          : Entity.fromJson(json["entity"]),
      latestPayslip: json["latestPayslip"] != null
          ? LatestPayslip.fromJson(json["latestPayslip"])
          : LatestPayslip(
              date: "", month: "", year: 0, statusCode: 0, message: ''),
      todayStatus: json["todayStatus"] != null
          ? TodayStatus.fromJson(json["todayStatus"])
          : TodayStatus(time: "", status: ""),
      leaveBalance: json["leaveBalance"] != null
          ? LeaveBalance.fromJson(json["leaveBalance"])
          : LeaveBalance(el: "", pending: "", cl: ""),
    );
  }
  final int statusCode;
  final String message;
  final Entity entity;
  final LatestPayslip latestPayslip;
  final TodayStatus todayStatus;
  final LeaveBalance leaveBalance;

  DashboardResponseEntity modelToEntity() {
    final LatestPayslipEntity latestPayslipEntity = LatestPayslipEntity(
        status: latestPayslip.message,
        date: "${latestPayslip.month} ${latestPayslip.year}");
    final TodayStatusEntity todayStatusEntity =
        TodayStatusEntity(status: todayStatus.status, time: todayStatus.time);
    final DashboardLeaveBalanceEntity leaveBalanceEntity =
        DashboardLeaveBalanceEntity(
            el: leaveBalance.el,
            pending: leaveBalance.pending,
            cl: leaveBalance.cl,
            ccl: leaveBalance.ccl);

    final List<RightEntity> rights = [];
    for (Right element in entity.rights) {
      rights.add(RightEntity(
          rightsName: element.childRightsName,
          rightsId: element.childRightsId,
          seqId: element.seqId));
    }

    final DashboardResponseEntity dashboardResponseEntity =
        DashboardResponseEntity(
      latestPayslip: latestPayslipEntity,
      todayStatus: todayStatusEntity,
      leaveBalance: leaveBalanceEntity,
      rights: rights,
    );
    return dashboardResponseEntity;
  }
}

class Entity {
  Entity({
    required this.rights,
    required this.parentRightsId,
  });

  factory Entity.fromJson(Map<String, dynamic> json) => Entity(
        rights: json["rights"] == null
            ? []
            : List<Right>.from(json["rights"].map((x) => Right.fromJson(x))),
        parentRightsId: json["parentRightsId"] ?? "",
      );
  final List<Right> rights;
  final String parentRightsId;
}

class Right {
  Right({
    required this.childRightsName,
    required this.childRightsId,
    required this.seqId,
  });

  factory Right.fromJson(Map<String, dynamic> json) => Right(
        childRightsName: json["childrightsname"] ?? "",
        childRightsId: json["childrightsid"] ?? "",
        seqId: json["seqid"] ?? 0,
      );
  final String childRightsName;
  final String childRightsId;
  final int seqId;
}

class LatestPayslip {
  LatestPayslip({
    required this.statusCode,
    required this.message,
    required this.date,
    required this.month,
    required this.year,
  });

  factory LatestPayslip.fromJson(Map<String, dynamic> json) => LatestPayslip(
        statusCode: json["statuscode"] ?? 400,
        message: json["message"] ?? "",
        date: json["date"] ?? "",
        month: json["month"] ?? "",
        year: json["year"] ?? 0,
      );
  final int statusCode;
  final String message;
  final String date;
  final String month;
  final int year;
}

class LeaveBalance {
  LeaveBalance({
    required this.el,
    required this.pending,
    required this.cl,
    this.ccl,
  });

  factory LeaveBalance.fromJson(Map<String, dynamic> json) => LeaveBalance(
        el: json["EL"] ?? "0",
        pending: json["pending"]?.toString() ?? "0",
        cl: json["CL"]?.toString() ?? "0",
        ccl: json["CCL"],
      );
  final String el;
  final String pending;
  final String cl;
  final String? ccl;
}

class TodayStatus {
  TodayStatus({
    required this.time,
    required this.status,
  });

  factory TodayStatus.fromJson(Map<String, dynamic> json) => TodayStatus(
        time: json["time"] ?? "",
        status: json["message"] ?? "",
      );
  final String time;
  final String status;
}
