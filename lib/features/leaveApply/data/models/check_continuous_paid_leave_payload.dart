import 'package:clientone_ess/core/service/sessionManagement/sessions.dart';

import '../../domain/entities/continuous_paid_leave.dart';

class CheckContinuousPaidLeavePayload {
  CheckContinuousPaidLeavePayload({
    required String fromDate,
    required String paidType,
    required String startFromFHSH,
    required String leaveTypeId,
    required String numberOfDaysApplied,
  }) {
    _fromDate = fromDate;
    _paidType = paidType;
    _startFromFHSH = startFromFHSH;
    _leaveTypeId = leaveTypeId;
    _numberOfDaysApplied = numberOfDaysApplied;
  }
  factory CheckContinuousPaidLeavePayload.copyWith(
      ContinuousPaidLeaveEntity postData) {
    return CheckContinuousPaidLeavePayload(
      fromDate: postData.fromDate,
      paidType: postData.paidType,
      startFromFHSH: postData.startFromFHSH,
      leaveTypeId: postData.leaveTypeId,
      numberOfDaysApplied: postData.numberOfDaysApplied,
    );
  }
  late final String _fromDate;
  late final String _paidType;
  late final String _startFromFHSH;
  late final String _leaveTypeId;
  late final String _numberOfDaysApplied;

  Map<String, dynamic> toJson() => {
        "fromdate": _fromDate,
        "payrollareaid": Sessions.getPayrollAreaId(),
        "employeecode": Sessions.getEmployeeCode(),
        "paidtype": _paidType,
        "startfromfhsh": _startFromFHSH,
        "leavetypeid": _leaveTypeId,
        "numberofdaysapplied": _numberOfDaysApplied,
        "companyid": Sessions.getCompanyId(),
        "employeeid": Sessions.getEmployeeId(),
        "userid": Sessions.getUserId(),
      };
}
