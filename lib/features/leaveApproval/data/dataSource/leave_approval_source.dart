import 'package:clientone_ess/core/exceptions/api_exceptions.dart';
import 'package:clientone_ess/core/network/apiClients/post_api_base.dart';

abstract class LeaveApprovalSource {
  Future<String> approveLeave(String empId, String leaveId, String? remark);

  Future<String> rejectLeave(String empId, String leaveId, String? remark);
}

class LeaveApprovalSourceImpl implements LeaveApprovalSource {
  @override
  Future<String> approveLeave(
      String empId, String leaveId, String? remark) async {
    final Map<String, dynamic> payload = {
      "selectedEmployeeId": empId,
      "remarks": remark,
      "status": "A",
      "documentnumber": leaveId
    };
    try {
      final Map<String, dynamic> json = await PostApiBase.instance
          .post(url: "", body: payload);
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
      "selectedEmployeeId": empId,
      "remarks": remark,
      "status": "R",
      "documentnumber": leaveId
    };

    try {
      final Map<String, dynamic> json = await PostApiBase.instance
          .post(url: "", body: payload);
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
