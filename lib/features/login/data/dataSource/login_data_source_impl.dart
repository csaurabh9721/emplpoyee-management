import 'package:clientone_ess/core/network/config/network_config.dart';
import 'package:clientone_ess/features/login/data/model/login_response_model.dart';
import 'package:clientone_ess/features/login/data/model/user_login_model.dart';

import '../../../../core/exceptions/api_exceptions.dart';
import '../../../../core/network/apiClients/post_api_base.dart';

abstract class LoginDataSource {
  Future<LoginModel> login(UserLoginModel userLoginModel);
}

class LoginDataSourceImpl implements LoginDataSource {
  @override
  Future<LoginModel> login(UserLoginModel userLoginModel) async {
    try {
      final Map<String, dynamic> response =
          await PostApiBase.instance.postApiWithBasicAuth(
        url: NetworkConfig.generateToken,
        body: userLoginModel.toJson(),
      );
      return LoginModel.fromJson(response);
    } catch (e) {
      throw AppException(e.toString());
    }
  }
}
