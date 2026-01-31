import 'package:clientone_ess/core/exceptions/api_exceptions.dart';
import 'package:clientone_ess/features/login/data/model/login_response_model.dart';
import 'package:clientone_ess/features/login/domain/entity/user_login_entity.dart';

import '../../domain/entity/login_response_entity.dart';
import '../../domain/repository/login_repository.dart';
import '../dataSource/login_data_source_impl.dart';
import '../model/user_login_model.dart';

class LoginRepositoryImpl implements LoginRepository {
  LoginRepositoryImpl(this._loginDataSource);
  final LoginDataSource _loginDataSource;

  @override
  Future<LoginResponseEntity> login(UserLoginEntity entity) async {
    final UserLoginModel userLoginModel =
        UserLoginModel(code: entity.code, password: entity.password);
    final LoginModel response = await _loginDataSource.login(userLoginModel);
    if (response.statusCode != 200) {
      throw AppException(response.message);
    }
    if (response.response == null) {
      throw AppException("Failed to login");
    }
    return response.response!;
  }
}
