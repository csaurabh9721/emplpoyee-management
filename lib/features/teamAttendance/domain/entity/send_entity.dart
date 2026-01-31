import '../../../../core/service/sessionManagement/sessions.dart';
import '../../../../shared/constants/app_constant.dart';

class TeamAttendanceRequest {

  TeamAttendanceRequest(
      {String? empId, String? reportingTo, required String startDate, required String endDate}) {
    _empId = empId ?? Sessions.getEmployeeId();
    _reportingTo = reportingTo ?? AppConstant.employeeName;
    _startDate = startDate;
    _endDate = endDate;
  }
  late final String _empId;
  late final String _startDate;
  late final String _endDate;
  late final String _reportingTo;

  String get endDate => _endDate;

  String get startDate => _startDate;

  String get empId => _empId;

  String get reportingTo => _reportingTo;
}
