import 'forget_password_repo.dart';

abstract class ForgetPasswordUseCase {
  Future<String> call(String empCode, String dob);
}

class ForgetPasswordUseCaseImpl implements ForgetPasswordUseCase {

  ForgetPasswordUseCaseImpl(this._repository);
  final ForgetPasswordRepository _repository;

  @override
  Future<String> call(String empCode, String dob) {
    return _repository.reset(empCode, dob);
  }
}
