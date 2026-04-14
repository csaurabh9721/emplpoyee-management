import 'package:clientone_ess/core/network/apiClients/post_api_base.dart';
import 'package:clientone_ess/core/network/config/network_config.dart';

import '../../../core/exceptions/api_exceptions.dart';
import '../models/login_model.dart';

class LoginService {
  final PostApiBase _apiClient = PostApiBase.instance;

  Future<LoginResponse> login(LoginRequest request) async {
    try {
      final Map<String, dynamic> response =
          await _apiClient.postApiWithBasicAuth(url: NetworkConfig.login, body: request.toJson());
      if (response["statusCode"] != 200 || response["body"] == null ) {
        throw AppException(response['message']);
      }
      return LoginResponse.fromJson(response);
    } catch (e) {
      throw AppException(e.toString());
    }
  }
}
