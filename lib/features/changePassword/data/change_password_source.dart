import 'package:clientone_ess/core/network/config/network_config.dart';
import '../../../core/exceptions/api_exceptions.dart';
import '../../../core/network/apiClients/post_api_base.dart';
import '../../../core/service/sessionManagement/sessions.dart';

abstract class ChangePasswordSource {
  Future<String> changePassword(
      String oldPassword, String newPassword, String confirmPassword);
}

class ChangePasswordSourceImpl implements ChangePasswordSource {
  @override
  Future<String> changePassword(
      String oldPassword, String newPassword, String confirmPassword) async {
    try {
      final Map<String, String> payload = {
        "oldpassword": oldPassword,
        "newpassword": newPassword,
        "confirmpassword": newPassword
      };
      final Map<String, dynamic> response = await PostApiBase.instance
          .post(url: "", body: payload);
      if (response["statuscode"].toString() == "200" ||
          response["status"].toString() == "200") {
        return response["message"];
      } else {
        throw AppException(response["message"] ?? "Failed to reset password.");
      }
    } catch (e) {
      throw AppException(e.toString());
    }
  }
}
