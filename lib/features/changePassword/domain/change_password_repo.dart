

abstract class ChangePasswordRepo {
  Future<String> change(String oldPassword, String newPassword, String confirmPassword);
}
