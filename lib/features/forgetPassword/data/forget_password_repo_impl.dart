import '../domain/forget_password_repo.dart';
import 'forget_password_source.dart';

class ForgetPasswordRepoImpl implements ForgetPasswordRepository {

  ForgetPasswordRepoImpl(this._source);
  final ForgetPasswordSource _source;

  @override
  Future<String> reset(String empCode, String dob) async {
    return _source.resetPassword(empCode, dob);
  }
}
