//import '../../../core/network/apiClients/get_api_base.dart';
import 'package:clientone_ess/core/exceptions/api_exceptions.dart';
import 'package:clientone_ess/core/network/apiClients/get_api_base.dart';
import 'package:clientone_ess/core/network/apiClients/post_api_base.dart';
import 'package:clientone_ess/core/network/config/network_config.dart';

import '../../../core/routes/routes_name.dart';
import '../models/dashboard_models.dart';
import '../models/punch_in_out_response.dart';

class DashboardService {
  //final GetApiBase _apiClient = GetApiBase.instance;

  Future<PunchInOutResponse> punchInOut(int employeeId, int organizationId) async {
    try {
      final Map<String, dynamic> json = await PostApiBase.instance.post(url: NetworkConfig.punchInOut, body: {
        "employeeId": employeeId,
        "organizationId": organizationId,
      });
      return PunchInOutResponse.fromJson(json);
    } catch (e) {
      throw AppException('Failed to punch in/out.');
    }
  }

  Future<DashboardDataModelBody> getDashboardData() async {
    final Map<String, dynamic> json = await GetApiBase.instance.getApi(url: NetworkConfig.dashboardData);
    try {
      return DashboardDataModel.fromJson(json).body;
    } catch (e) {
      throw Exception('Failed to load dashboard data.');
    }
  }
}
