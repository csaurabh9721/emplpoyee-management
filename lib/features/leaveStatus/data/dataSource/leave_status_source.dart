import 'package:clientone_ess/core/service/sessionManagement/sessions.dart';

import '../../../../core/exceptions/api_exceptions.dart';
import '../../../../core/network/apiClients/post_api_base.dart';
import '../../../../core/network/config/network_config.dart';
import '../models/leave_status_model.dart';

abstract class LeaveStatusSource {
  Future<bool> withdrawLeave(String leaveApplicationNo, String withdrawReason);

  Future<LeaveStatusResponseModel> getLeaveCode(
      {required String fromDate,
      required String toDate,
      required String leaveType,
      required String leaveStatus});
}

class LeaveStatusSourceImpl implements LeaveStatusSource {
  @override
  Future<LeaveStatusResponseModel> getLeaveCode(
      {required String fromDate,
      required String toDate,
      required String leaveType,
      required String leaveStatus}) async {
    try {
      final Map<String, String> payload = {
        "employeeid": Sessions.getEmployeeId(),
        "payrollareaid": Sessions.getPayrollAreaId(),
        "fromdate": fromDate,
        "todate": toDate,
        "leavetypeid": leaveType.toUpperCase(),
        "leavestatus": leaveStatus.toUpperCase()
      };
      final Map<String, dynamic> json = await PostApiBase.instance
          .post(url: NetworkConfig.leaveStatus, body: payload);
      return LeaveStatusResponseModel.fromJson(json);
    } catch (e) {
      throw AppException(e.toString());
    }
  }

  @override
  Future<bool> withdrawLeave(
      String leaveApplicationNo, String withdrawReason) async {
    try {
      final Map<String, String> payload = {
        "leaveapplicationno": leaveApplicationNo,
        "reason": withdrawReason
      };
      final Map<String, dynamic> json = await PostApiBase.instance
          .post(url: NetworkConfig.leaveWithdraw, body: payload);
      if (json['status'] == "200") {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      throw AppException(e.toString());
    }
  }
}
