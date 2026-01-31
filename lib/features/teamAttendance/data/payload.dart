import '../../../core/service/sessionManagement/sessions.dart';
import '../domain/entity/send_entity.dart';

class TeamAttendancePayload {

  TeamAttendancePayload(TeamAttendanceRequest request) {
    _empId = request.empId;
    _startDate = request.startDate;
    _endDate = request.endDate;
  }
  late final String _empId;
  late final String _startDate;
  late final String _endDate;

  Map<String, dynamic> get toJson => {
        "employeeid": _empId,
        "payrollareaid": Sessions.getPayrollAreaId(),
        "fromdate": _startDate,
        "todate": _endDate,
        "userid": Sessions.getUserId()
      };
}
