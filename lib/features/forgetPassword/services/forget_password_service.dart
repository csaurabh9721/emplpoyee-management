import '../models/forget_password_model.dart';

class ForgetPasswordService {
  Future<ForgetPasswordResponse> forgetPassword(ForgetPasswordRequest request) async {
    // Simulate API call
    await Future.delayed(const Duration(seconds: 2));
    try {
      if (request.email.isNotEmpty && request.employeeCode.isNotEmpty) {
        return ForgetPasswordResponse(
          success: true,
          message: 'Password reset instructions have been sent to your email.',
        );
      } else {
        return ForgetPasswordResponse(
          success: false,
          message: 'Invalid email or employee code.',
        );
      }
    } catch (e) {
      throw Exception('Failed to process request: $e');
    }
  }
}
