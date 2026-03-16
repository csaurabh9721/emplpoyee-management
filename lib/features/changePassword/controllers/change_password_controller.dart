import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/utils/base_api_response.dart';
import '../models/change_password_model.dart';
import '../services/change_password_service.dart';

class ChangePasswordController extends GetxController {
  final ChangePasswordService _changePasswordService = ChangePasswordService();

  // Form controllers
  final TextEditingController oldPasswordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  // State management
  BaseApiResponse<ChangePasswordResponse> changePasswordResponse = BaseApiResponse.initial();
  bool obscureOldPassword = true;
  bool obscureNewPassword = true;
  bool obscureConfirmPassword = true;

  Future<void> changePassword() async {
    if (!validateForm()) return;

    try {
      changePasswordResponse = BaseApiResponse.loading();
      update();

      final request = ChangePasswordRequest(
        oldPassword: oldPasswordController.text.trim(),
        newPassword: newPasswordController.text.trim(),
      );

      final response = await _changePasswordService.changePassword(request);
      changePasswordResponse = BaseApiResponse.success(data: response);
      update();

      if (response.success) {
        Get.snackbar(
          'Success',
          response.message,
          backgroundColor: Colors.green,
          colorText: Colors.white,
          duration: const Duration(seconds: 3),
        );
        
        // Clear fields and potentially go back
        oldPasswordController.clear();
        newPasswordController.clear();
        confirmPasswordController.clear();
        Future.delayed(const Duration(seconds: 2), () => Get.back());
      } else {
        Get.snackbar(
          'Error',
          response.message,
          backgroundColor: Colors.red,
          colorText: Colors.white,
          duration: const Duration(seconds: 3),
        );
      }
    } catch (e) {
      changePasswordResponse = BaseApiResponse.error(e.toString());
      update();
      Get.snackbar(
        'Error',
        'Failed to change password. Please try again.',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        duration: const Duration(seconds: 2),
      );
    }
  }

  bool validateForm() {
    if (oldPasswordController.text.trim().isEmpty) {
      Get.snackbar('Validation Error', 'Old password is required');
      return false;
    }
    if (newPasswordController.text.trim().length < 6) {
      Get.snackbar('Validation Error', 'New password must be at least 6 characters');
      return false;
    }
    if (newPasswordController.text != confirmPasswordController.text) {
      Get.snackbar('Validation Error', 'Passwords do not match');
      return false;
    }
    return true;
  }

  void toggleOldPasswordVisibility() {
    obscureOldPassword = !obscureOldPassword;
    update();
  }

  void toggleNewPasswordVisibility() {
    obscureNewPassword = !obscureNewPassword;
    update();
  }

  void toggleConfirmPasswordVisibility() {
    obscureConfirmPassword = !obscureConfirmPassword;
    update();
  }

  @override
  void onClose() {
    oldPasswordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }
}
