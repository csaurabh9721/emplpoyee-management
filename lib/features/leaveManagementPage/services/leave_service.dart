import 'package:clientone_ess/core/network/apiClients/get_api_base.dart';
import 'package:clientone_ess/core/network/apiClients/post_api_base.dart';
import 'package:flutter/material.dart';

import '../../../core/exceptions/api_exceptions.dart';
import '../../../core/network/config/network_config.dart';
import '../models/leave_models.dart';

class LeaveService {
  Future<List<LeaveBalanceModel>> getLeaveManagementData() async {
    try {
      final Map<String, dynamic> json =
          await GetApiBase.instance.getApi(url: NetworkConfig.getLeaveBalance);
      if (json["statusCode"] != 200 && json["body"] == null) {
        throw AppException(json["message"] ?? "Something went wrong");
      }
      return List.from(
          json["body"].map((item) => LeaveBalanceModel.fromJson(item)));
    } catch (e) {
      debugPrint(e.toString());
      throw AppException('Failed to load leave management data.');
    }
  }

  Future<List<LeaveResponseModel>> getAllLeaveRequests() async {
    try {
      final Map<String, dynamic> json = await GetApiBase.instance
          .getApi(url: NetworkConfig.getLeaveForEmployee);
      if (json["statusCode"] != 200 && json["body"] == null) {
        throw AppException(json["message"] ?? "Something went wrong");
      }

      return List.from(json["body"].map((e) => LeaveResponseModel.fromJson(e)));
    } catch (e) {
      debugPrint(e.toString());

      throw AppException('Failed to load leave requests: $e');
    }
  }
}
