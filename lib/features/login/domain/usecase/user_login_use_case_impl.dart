import 'package:clientone_ess/features/login/domain/entity/login_response_entity.dart';
import 'package:clientone_ess/features/login/domain/entity/user_login_entity.dart';
import '../repository/login_repository.dart';

abstract class UserLoginUseCase {
  Future<LoginResponseEntity> login(UserLoginEntity userLoginEntity);
}

class UserLoginUseCaseImpl implements UserLoginUseCase {
  UserLoginUseCaseImpl(this._loginRepository);
  final LoginRepository _loginRepository;

  @override
  Future<LoginResponseEntity> login(UserLoginEntity userLoginEntity) {
    return _loginRepository.login(userLoginEntity);
  }
}
