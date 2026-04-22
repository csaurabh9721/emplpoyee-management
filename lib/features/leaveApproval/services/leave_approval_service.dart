import 'package:clientone_ess/core/network/apiClients/put_api_base.dart';
import 'package:flutter/cupertino.dart';
import '../../../core/exceptions/api_exceptions.dart';
import '../../../core/network/apiClients/get_api_base.dart';
import '../../../core/network/config/network_config.dart';
import '../../leaveManagementPage/models/leave_models.dart';

class LeaveApprovalService {
  Future<List<LeaveResponseModel>> getAllAppliedLeaveRequests() async {
    try {
      final Map<String, dynamic> json = await GetApiBase.instance.getApi(url: NetworkConfig.getLeaveForApproval);
      if (json["statusCode"] != 200 && json["body"] == null) {
        throw AppException(json["message"] ?? "Something went wrong");
      }
      return List.from(json["body"].map((e) => LeaveResponseModel.fromJson(e)));
    } catch (e) {
      debugPrint(e.toString());
      throw AppException('$e');
    }
  }

  Future<String> approveLeave(int id) async {
    try {
      final Map<String, dynamic> json = await PutApiBase.instance.putApi(url: "${NetworkConfig.leaveApprove}/$id");
      if (json["statusCode"] != 200 && json["body"] == null) {
        throw AppException(json["message"] ?? "Something went wrong");
      }
      return "Leave request approved successfully";
    } catch (e) {
      debugPrint(e.toString());
      throw AppException('$e');
    }
  }

  Future<String> rejectLeave(int id) async {
    try {
      final Map<String, dynamic> json = await PutApiBase.instance.putApi(url: "${NetworkConfig.leaveReject}/$id");
      if (json["statusCode"] != 200 && json["body"] == null) {
        throw AppException(json["message"] ?? "Something went wrong");
      }
      return "Leave request rejected successfully";
    } catch (e) {
      debugPrint(e.toString());
      throw AppException('$e');
    }
  }
}
