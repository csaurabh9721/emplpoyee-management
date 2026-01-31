import 'package:clientone_ess/core/service/sessionManagement/sessions.dart';
import 'package:clientone_ess/features/landing/data/models/dashboard_response_model.dart';

import '../../../../core/exceptions/api_exceptions.dart';
import '../../../../core/network/apiClients/post_api_base.dart';
import '../../../../core/network/config/network_config.dart';

abstract class DashboardSource {
  Future<DashboardResponseModel> getDashBoardData();
}

class DashboardSourceImpl implements DashboardSource {
  @override
  Future<DashboardResponseModel> getDashBoardData() async {
    try {
      final Map<String, dynamic> payload = {
        "employeeid": Sessions.getEmployeeId(),
        "payrollareaid": Sessions.getPayrollAreaId(),
        "employeecode": Sessions.getEmployeeCode()
      };
      final Map<String, dynamic> response = await PostApiBase.instance
          .post(url: "", body: payload);
      final DashboardResponseModel data =
          DashboardResponseModel.fromJson(response);
      return data;
    } catch (e) {
      throw AppException(e.toString());
    }
  }
}
