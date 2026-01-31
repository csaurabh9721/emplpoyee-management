import 'package:clientone_ess/features/login/domain/entity/user_login_entity.dart';
import '../entity/login_response_entity.dart';

abstract class LoginRepository {
  Future<LoginResponseEntity> login(UserLoginEntity userLoginEntity);
}
