import '../domain/change_password_repo.dart';
import 'change_password_source.dart';

class ChangePasswordRepoImpl implements ChangePasswordRepo {

  ChangePasswordRepoImpl(this._source);
  final ChangePasswordSource _source;

  @override
  Future<String> change(String oldPassword, String newPassword, String confirmPassword) async {
    return _source.changePassword(oldPassword, newPassword, confirmPassword);
  }
}
