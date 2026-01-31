class ApplyLeaveBalanceEntity {

  const ApplyLeaveBalanceEntity(
      {required this.holiDayPopup, required this.leaveList, required this.message});
  final bool holiDayPopup;
  final List<LeaveListEntity> leaveList;
  final String message;
}

class LeaveListEntity {

  LeaveListEntity({
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
  final double noOfMaxAttempt;
  final double availed;
  final double minimumLeave;
  final String paidType;
  final String advanceLeave;
  final String maintainBalance;
  final String leaveTypeCode;
  final String nextCreditOn;
  final double leaveBalance;
  final String payrollAreaCode;
  final double maximumLeave;
  final double creditDays;
  final double attemptedLeveCount;
  final String payrollUniqueId;
  final String payrollAreaId;
  final String leaveMasterOpeningDate;
  final String leaveTypeId;
  final String documentRequired;
  final String datePeriodFrom;
  final String datePeriodTo;
}
