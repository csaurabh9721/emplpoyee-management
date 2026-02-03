import 'package:clientone_ess/core/network/apiClients/post_api_base.dart';
import 'package:clientone_ess/core/network/config/network_config.dart';
import 'package:clientone_ess/core/service/sessionManagement/sessions.dart';

import '../../../core/exceptions/api_exceptions.dart';
import 'model.dart';

abstract class LeaveHistorySource {
  Future<LeaveHistoryModel> getData(String startDate, String endDate);
}

class LeaveHistorySourceImpl implements LeaveHistorySource {
  @override
  Future<LeaveHistoryModel> getData(String startDate, String endDate) async {
    try {
      final Map<String, String> body = {
        "startdate": startDate,
        "enddate": endDate,
      };
      final Map<String, dynamic> json = await PostApiBase.instance
          .post(url: "", body: body);
      return LeaveHistoryModel.fromJson(json);
    } catch (e) {
      throw AppException(e.toString());
    }
  }
}
