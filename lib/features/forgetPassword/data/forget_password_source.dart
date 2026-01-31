import 'package:clientone_ess/core/network/config/network_config.dart';

import '../../../core/exceptions/api_exceptions.dart';
import '../../../core/network/apiClients/post_api_base.dart';

abstract class ForgetPasswordSource {
  Future<String> resetPassword(String empCode, String dob);
}

class ForgetPasswordSourceImpl implements ForgetPasswordSource {
  @override
  Future<String> resetPassword(String empCode, String dob) async {
    try {
      final Map<String, String> payload = {"employeecode": empCode, "dob": dob};
      final Map<String, dynamic> response = await PostApiBase.instance
          .post(url: NetworkConfig.forgotPassword, body: payload);
      final String status =
          (response["status"] ?? response["statuscode"]).toString();
      if (status == "200") {
        return response["message"];
      } else {
        throw AppException(response["message"] ?? "Failed to reset password.");
      }
    } catch (e) {
      throw AppException(e.toString());
    }
  }
}
