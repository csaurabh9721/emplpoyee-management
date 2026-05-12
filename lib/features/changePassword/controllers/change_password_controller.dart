import 'package:clientone_ess/core/exceptions/api_exceptions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/service/sessionManagement/sessions.dart';
import '../models/change_password_model.dart';
import '../services/change_password_service.dart';

class ChangePasswordController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController oldPasswordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  bool obscureOldPassword = true;
  bool obscureNewPassword = true;
  bool obscureConfirmPassword = true;
  RxBool isLoading = false.obs;

  Future<void> changePassword() async {
    if (!formKey.currentState!.validate()) return;
    try {
      if(  oldPasswordController.text.trim() ==
          newPasswordController.text.trim() ||
          oldPasswordController.text.trim() ==
              confirmPasswordController.text.trim()){
        throw AppException("New password can not be same as old passwprd.");
      }
      isLoading.value = true;
      final request = ChangePasswordRequest(
        oldPassword: oldPasswordController.text.trim(),
        newPassword: newPasswordController.text.trim(),
        confirmPassword: confirmPasswordController.text.trim(),
      );
      final response = await ChangePasswordService().changePassword(request);
      if (response.body) {
        oldPasswordController.clear();
        newPasswordController.clear();
        confirmPasswordController.clear();
        Get.back();
        Get.snackbar(
          'Success',
          response.message,
          backgroundColor: Colors.green,
          colorText: Colors.white,
          duration: const Duration(seconds: 3),
        );

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
      Get.snackbar(
        'Error',
        e.toString(),
        backgroundColor: Colors.red,
        colorText: Colors.white,
        duration: const Duration(seconds: 2),
      );
    } finally {
      isLoading.value = false;
    }
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
