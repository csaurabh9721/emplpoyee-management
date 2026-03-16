import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/utils/base_api_response.dart';
import '../models/forget_password_model.dart';
import '../services/forget_password_service.dart';

class ForgetPasswordController extends GetxController {
  final ForgetPasswordService _forgetPasswordService = ForgetPasswordService();

  // Form controllers
  final TextEditingController emailController = TextEditingController();
  final TextEditingController employeeCodeController = TextEditingController();

  // State management
  BaseApiResponse<ForgetPasswordResponse> forgetPasswordResponse = BaseApiResponse.initial();

  Future<void> submitForgetPassword() async {
    if (!validateForm()) return;

    try {
      forgetPasswordResponse = BaseApiResponse.loading();
      update();

      final request = ForgetPasswordRequest(
        email: emailController.text.trim(),
        employeeCode: employeeCodeController.text.trim(),
      );

      final response = await _forgetPasswordService.forgetPassword(request);
      forgetPasswordResponse = BaseApiResponse.success(data: response);
      update();

      if (response.success) {
        Get.snackbar(
          'Success',
          response.message,
          backgroundColor: Colors.green,
          colorText: Colors.white,
          duration: const Duration(seconds: 3),
        );
        
        // Navigate back to login after success
        Future.delayed(const Duration(seconds: 3), () {
          Get.back();
        });
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
      forgetPasswordResponse = BaseApiResponse.error(e.toString());
      update();
      Get.snackbar(
        'Error',
        'Something went wrong. Please try again.',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        duration: const Duration(seconds: 2),
      );
    }
  }

  bool validateForm() {
    if (emailController.text.trim().isEmpty) {
      Get.snackbar(
        'Validation Error',
        'Please enter your email',
        backgroundColor: Colors.orange,
        colorText: Colors.white,
        duration: const Duration(seconds: 2),
      );
      return false;
    }

    if (!GetUtils.isEmail(emailController.text.trim())) {
      Get.snackbar(
        'Validation Error',
        'Please enter a valid email address',
        backgroundColor: Colors.orange,
        colorText: Colors.white,
        duration: const Duration(seconds: 2),
      );
      return false;
    }

    if (employeeCodeController.text.trim().isEmpty) {
      Get.snackbar(
        'Validation Error',
        'Please enter your employee code',
        backgroundColor: Colors.orange,
        colorText: Colors.white,
        duration: const Duration(seconds: 2),
      );
      return false;
    }

    return true;
  }

  @override
  void onClose() {
    emailController.dispose();
    employeeCodeController.dispose();
    super.onClose();
  }
}
