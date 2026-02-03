import 'package:clientone_ess/core/exceptions/api_exceptions.dart';
import 'package:clientone_ess/core/network/apiClients/post_api_base.dart';
import 'package:clientone_ess/core/network/config/network_config.dart';
import 'package:clientone_ess/core/service/sessionManagement/sessions.dart';

import '../models/leave_balance_model.dart';

abstract class GetLeaveBalanceDataSource {
  Future<ApplyLeaveBalanceResponseModel> getLeaveBalance(String date);
}

class GetLeaveBalanceDataSourceImpl implements GetLeaveBalanceDataSource {
  @override
  Future<ApplyLeaveBalanceResponseModel> getLeaveBalance(String date) async {
    try {
      final Map<String, String> payload = {
        "fromdate": date,
      };
      final Map<String, dynamic> json = await PostApiBase.instance
          .post(url: "", body: payload);
      return ApplyLeaveBalanceResponseModel.fromJson(json);
    } catch (e) {
      throw AppException(e.toString());
    }
  }
}
