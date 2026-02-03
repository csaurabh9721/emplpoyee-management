import 'package:clientone_ess/features/login/data/model/login_response_model.dart';
import 'package:clientone_ess/features/login/data/model/user_login_model.dart';
import '../../../../core/exceptions/api_exceptions.dart';

abstract class LoginDataSource {
  Future<LoginModel> login(UserLoginModel userLoginModel);
}

class LoginDataSourceImpl implements LoginDataSource {
  @override
  Future<LoginModel> login(UserLoginModel userLoginModel) async {
    try {
      // final Map<String, dynamic> response =
      //     await PostApiBase.instance.postApiWithBasicAuth(
      //   url: "",
      //   body: userLoginModel.toJson(),
      // );
      await Future.delayed(const Duration(seconds: 1));
      final Map<String, dynamic> response = {
        "statuscode": 200,
        "entity": {"userid": "1", "token": "token"},
        "message": "Login Success"
      };
      return LoginModel.fromJson(response);
    } catch (e) {
      throw AppException(e.toString());
    }
  }
}
