import 'package:clientone_ess/core/network/apiClients/get_api_base.dart';
import 'package:clientone_ess/core/network/apiClients/post_api_base.dart';
import 'package:flutter/material.dart';

import '../../../core/exceptions/api_exceptions.dart';
import '../../../core/network/config/network_config.dart';
import '../models/leave_models.dart';

class LeaveService {
  Future<List<LeaveBalanceModel>> getLeaveManagementData() async {
    try {
      final Map<String, dynamic> json = await GetApiBase.instance.getApi(url: NetworkConfig.getLeaveBalance);
      if (json["statusCode"] != 200 && json["body"] == null) {
        throw AppException(json["message"] ?? "Something went wrong");
      }
      return List.from(json["body"].map((item) => LeaveBalanceModel.fromJson(item)));
    } catch (e) {
      debugPrint(e.toString());
      throw AppException('Failed to load leave management data.');
    }
  }

  Future<List<LeaveRequestModel>> getAllLeaveRequests() async {
    try {
      await Future.delayed(const Duration(seconds: 1));

      // Return more detailed leave requests
      return [
        LeaveRequestModel(
          id: '1',
          type: 'Annual Leave',
          startDate: 'Oct 12, 2023',
          endDate: 'Oct 15, 2023',
          days: 4,
          status: 'PENDING',
          reason: 'Family vacation',
          appliedDate: DateTime.parse('2023-10-10'),
        ),
        LeaveRequestModel(
          id: '2',
          type: 'Sick Leave',
          startDate: 'Sep 20, 2023',
          endDate: 'Sep 20, 2023',
          days: 1,
          status: 'APPROVED',
          reason: 'Medical appointment',
          appliedDate: DateTime.parse('2023-09-19'),
        ),
        LeaveRequestModel(
          id: '3',
          type: 'Personal Leave',
          startDate: 'Aug 05, 2023',
          endDate: 'Aug 06, 2023',
          days: 2,
          status: 'REJECTED',
          reason: 'Personal work',
          appliedDate: DateTime.parse('2023-08-04'),
        ),
        LeaveRequestModel(
          id: '4',
          type: 'Annual Leave',
          startDate: 'Jul 10, 2023',
          endDate: 'Jul 14, 2023',
          days: 5,
          status: 'APPROVED',
          reason: 'Summer vacation',
          appliedDate: DateTime.parse('2023-07-08'),
        ),
        LeaveRequestModel(
          id: '5',
          type: 'Sick Leave',
          startDate: 'Jun 15, 2023',
          endDate: 'Jun 16, 2023',
          days: 2,
          status: 'APPROVED',
          reason: 'Flu symptoms',
          appliedDate: DateTime.parse('2023-06-14'),
        ),
      ];
    } catch (e) {
      throw Exception('Failed to load leave requests: $e');
    }
  }
}
