import '../models/change_password_model.dart';

class ChangePasswordService {
  Future<ChangePasswordResponse> changePassword(ChangePasswordRequest request) async {
    // Simulate API call
    await Future.delayed(const Duration(seconds: 2));
    try {
      if (request.oldPassword == 'password123') { // Mock check
        return ChangePasswordResponse(
          success: true,
          message: 'Password changed successfully.',
        );
      } else {
        return ChangePasswordResponse(
          success: false,
          message: 'Incorrect old password.',
        );
      }
    } catch (e) {
      throw Exception('Failed to change password: $e');
    }
  }
}
