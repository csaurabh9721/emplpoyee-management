import 'package:clientone_ess/core/exceptions/api_exceptions.dart';
import 'package:clientone_ess/core/network/apiClients/post_api_base.dart';
import 'package:clientone_ess/core/network/config/network_config.dart';
import 'package:clientone_ess/core/service/sessionManagement/sessions.dart';

abstract class LeaveApprovalSource {
  Future<String> approveLeave(String empId, String leaveId, String? remark);

  Future<String> rejectLeave(String empId, String leaveId, String? remark);
}

class LeaveApprovalSourceImpl implements LeaveApprovalSource {
  @override
  Future<String> approveLeave(
      String empId, String leaveId, String? remark) async {
    final Map<String, dynamic> payload = {
      "aaprovalEmployeeId": Sessions.getEmployeeId(),
      "selectedEmployeeId": empId,
      "payrollareaid": Sessions.getPayrollAreaId(),
      "remarks": remark,
      "status": "A",
      "companyid": Sessions.getCompanyId(),
      "documentnumber": leaveId
    };
    try {
      final Map<String, dynamic> json = await PostApiBase.instance
          .post(url: NetworkConfig.leaveApproval, body: payload);
      final String message =
          json["message"] ?? json["status"] ?? "Failed to approve leave.";
      if (json["statuscode"] != 200) {
        throw AppException(message);
      }
      return message;
    } catch (e) {
      throw AppException(e.toString());
    }
  }

  @override
  Future<String> rejectLeave(
      String empId, String leaveId, String? remark) async {
    final Map<String, dynamic> payload = {
      "aaprovalEmployeeId": Sessions.getEmployeeId(),
      "selectedEmployeeId": empId,
      "payrollareaid": Sessions.getPayrollAreaId(),
      "remarks": remark,
      "status": "R",
      "companyid": Sessions.getCompanyId(),
      "documentnumber": leaveId
    };

    try {
      final Map<String, dynamic> json = await PostApiBase.instance
          .post(url: NetworkConfig.leaveApproval, body: payload);
      final String message =
          json["message"] ?? json["status"] ?? "Failed to reject leave.";
      if (json["statuscode"] != 200) {
        throw AppException(message);
      }
      return message;
    } catch (e) {
      throw AppException(e.toString());
    }
  }
}
