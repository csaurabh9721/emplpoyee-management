import 'package:clientone_ess/core/network/apiClients/get_api_base.dart';
import 'package:clientone_ess/core/network/config/network_config.dart';
import '../../../core/exceptions/api_exceptions.dart';

class GetLeaveTypeService {
  Future<List<String>> fetchLeaveTypes() async {
    try {
      final Map<String, dynamic> response = await GetApiBase.instance.getApi(
        url: NetworkConfig.getLeaveType,
      );
      if (response["statusCode"] != 200 || response["body"] == null) {
        throw AppException("Failed to fetch leave types");
      }
      return List<String>.from(response["body"].map((x) => x));
    } catch (e) {
      rethrow;
    }
  }
}
