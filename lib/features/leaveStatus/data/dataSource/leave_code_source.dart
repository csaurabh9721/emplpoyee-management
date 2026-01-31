import 'package:clientone_ess/core/network/apiClients/post_api_base.dart';
import 'package:clientone_ess/core/network/config/network_config.dart';
import 'package:clientone_ess/core/service/sessionManagement/sessions.dart';

import '../../../../core/exceptions/api_exceptions.dart';
import '../models/leave_code_model.dart';

abstract class LeaveCodeSource {
  Future<LeaveCodeResponseModel> getLeaveCode();
}

class LeaveCodeSourceImpl implements LeaveCodeSource {
  @override
  Future<LeaveCodeResponseModel> getLeaveCode() async {
    try {
      final Map<String, String> payload = {
        "employeeid": Sessions.getEmployeeId()
      };
      final Map<String, dynamic> json = await PostApiBase.instance
          .post(url: NetworkConfig.leaveDetail, body: payload);
      return LeaveCodeResponseModel.fromJson(json);
    } catch (e) {
      throw AppException(e.toString());
    }
  }
}
