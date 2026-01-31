import 'change_password_repo.dart';

abstract class ChangePasswordUseCase {
  Future<String> call(String oldPassword, String newPassword, String confirmPassword);
}

class ChangePasswordUseCaseImpl implements ChangePasswordUseCase {

  ChangePasswordUseCaseImpl(this._repository);
  final ChangePasswordRepo _repository;

  @override
  Future<String> call(String oldPassword, String newPassword, String confirmPassword) {
    return _repository.change(oldPassword, newPassword, confirmPassword);
  }
}
