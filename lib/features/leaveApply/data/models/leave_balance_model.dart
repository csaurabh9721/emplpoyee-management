import '../../domain/entities/leave_balance_entity.dart';

class ApplyLeaveBalanceResponseModel {

  ApplyLeaveBalanceResponseModel({
    required this.statusCode,
    required this.entity,
    required this.message,
    required this.holiDayPopup,
  });

  factory ApplyLeaveBalanceResponseModel.fromJson(Map<String, dynamic> json) {
    return ApplyLeaveBalanceResponseModel(
      statusCode: json['statuscode']?.toString() ?? "400",
      entity: json["leavebalanceMap"] == null
          ? []
          : List<LeaveBalanceMap>.from(
              json["leavebalanceMap"].map((x) => LeaveBalanceMap.fromJson(x))),
      message: json['message'] ?? "Something went wrong",
      holiDayPopup: json['holidaypopup'].toString() == "true" ? true : false,
    );
  }
  final String statusCode;
  final List<LeaveBalanceMap> entity;
  final String message;
  final bool holiDayPopup;

  ApplyLeaveBalanceEntity dtoToEntity() {
    final List<LeaveListEntity> leaveList = entity.map((e) => e.dtoToEntity()).toList();
    return ApplyLeaveBalanceEntity(
        holiDayPopup: holiDayPopup, leaveList: leaveList, message: message);
  }
}

class LeaveBalanceMap {

  LeaveBalanceMap({
    required this.noOfMaxAttempt,
    required this.availed,
    required this.minimumLeave,
    required this.paidType,
    required this.advanceLeave,
    required this.maintainBalance,
    required this.leaveTypeCode,
    required this.nextCreditOn,
    required this.leaveBalance,
    required this.payrollAreaCode,
    required this.maximumLeave,
    required this.creditDays,
    required this.attemptedLeveCount,
    required this.payrollUniqueId,
    required this.payrollAreaId,
    required this.leaveMasterOpeningDate,
    required this.leaveTypeId,
    required this.documentRequired,
    required this.datePeriodFrom,
    required this.datePeriodTo,
  });

  factory LeaveBalanceMap.fromJson(Map<String, dynamic> json) => LeaveBalanceMap(
        noOfMaxAttempt: json["noofmaxattepmts"] ?? "0",
        availed: json["aviled"] ?? "0",
        minimumLeave: json["minimumleave"] ?? "0",
        paidType: json["paidtype"] ?? "P",
        advanceLeave: json["advanceleave"] ?? "Y",
        maintainBalance: json["maintainbalance"] ?? "Y",
        leaveTypeCode: json["leavetypecode"] ?? "",
        nextCreditOn: json["nextcrediton"] ?? "",
        leaveBalance: json["leavebalance"] ?? "0",
        payrollAreaCode: json["payrollareacode"] ?? "",
        maximumLeave: json["maximumleave"] ?? "0",
        creditDays: json["creditdays"] ?? "0",
        attemptedLeveCount: json["attemtedlevecount"] ?? 0.0,
        payrollUniqueId: json["payrolluniqueid"] ?? "",
        payrollAreaId: json["payrollareaid"] ?? "",
        leaveMasterOpeningDate: json["leaveMasteropeningdate"] ?? "",
        leaveTypeId: json["leavetypeid"] ?? "",
        documentRequired: json["documentrequired"] ?? "",
        datePeriodFrom: json["dateperiodfrom"] ?? "",
        datePeriodTo: json["dateperiodto"] ?? "",
      );
  final String noOfMaxAttempt;
  final String availed;
  final String minimumLeave;
  final String paidType;
  final String advanceLeave;
  final String maintainBalance;
  final String leaveTypeCode;
  final String nextCreditOn;
  final String leaveBalance;
  final String payrollAreaCode;
  final String maximumLeave;
  final String creditDays;
  final double attemptedLeveCount;
  final String payrollUniqueId;
  final String payrollAreaId;
  final String leaveMasterOpeningDate;
  final String leaveTypeId;
  final String documentRequired;
  final String datePeriodFrom;
  final String datePeriodTo;

  LeaveListEntity dtoToEntity() {
    return LeaveListEntity(
      noOfMaxAttempt: double.parse(noOfMaxAttempt),
      availed: double.parse(availed),
      minimumLeave: double.parse(minimumLeave),
      paidType: paidType,
      advanceLeave: advanceLeave,
      maintainBalance: maintainBalance,
      leaveTypeCode: leaveTypeCode,
      nextCreditOn: nextCreditOn,
      leaveBalance: double.parse(leaveBalance),
      payrollAreaCode: payrollAreaCode,
      maximumLeave: double.parse(maximumLeave),
      creditDays: double.parse(creditDays),
      attemptedLeveCount: attemptedLeveCount,
      payrollUniqueId: payrollUniqueId,
      payrollAreaId: payrollAreaId,
      leaveMasterOpeningDate: leaveMasterOpeningDate,
      leaveTypeId: leaveTypeId,
      documentRequired: documentRequired,
      datePeriodFrom: datePeriodFrom,
      datePeriodTo: datePeriodTo,
    );
  }
}
