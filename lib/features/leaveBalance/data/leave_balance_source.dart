import 'package:clientone_ess/core/exceptions/api_exceptions.dart';
import 'package:clientone_ess/core/network/apiClients/post_api_base.dart';
import 'package:clientone_ess/core/network/config/network_config.dart';
import 'package:clientone_ess/core/service/sessionManagement/sessions.dart';

import 'model.dart';

abstract class LeaveBalanceSource {
  Future<LeaveBalanceModel> getData(String date);
}

class LeaveBalanceSourceImpl implements LeaveBalanceSource {
  @override
  Future<LeaveBalanceModel> getData(String date) async {
    try {
      final Map<String, String> body = {
        "asOnDate": date
      };
      final Map<String, dynamic> json = await PostApiBase.instance
          .post(url: "", body: body);
      return LeaveBalanceModel.fromJson(json);
    } catch (e) {
      throw AppException(e.toString());
    }
  }
}
