import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/utils/base_api_response.dart';
import '../models/login_model.dart';
import '../services/login_service.dart';

class LoginController extends GetxController {
  final LoginService _loginService = LoginService();

  // Form controllers
  final TextEditingController employeeIdController = TextEditingController(text: "EMP001");
  final TextEditingController passwordController = TextEditingController(text: "password");

  // State management
  BaseApiResponse<LoginResponse> loginResponse = BaseApiResponse.initial();
  bool obscurePassword = true;

  Future<void> login() async {
    try {
      loginResponse = BaseApiResponse.loading();
      update();

      final request = LoginRequest(
        employeeId: employeeIdController.text.trim(),
        password: passwordController.text.trim(),
      );

      final response = await _loginService.login(request);
      loginResponse = BaseApiResponse.success(data: response);
      update();

      if (response.success) {
        Get.snackbar(
          'Success',
          response.message,
          backgroundColor: Colors.green,
          colorText: Colors.white,
          duration: const Duration(seconds: 2),
        );
        
        // Navigate to dashboard after successful login
        Future.delayed(const Duration(seconds: 2), () {
          Get.offAllNamed('/dashboard');
        });
      } else {
        Get.snackbar(
          'Login Failed',
          response.message,
          backgroundColor: Colors.red,
          colorText: Colors.white,
          duration: const Duration(seconds: 3),
        );
      }
    } catch (e) {
      loginResponse = BaseApiResponse.error(e.toString());
      update();
      Get.snackbar(
        'Error',
        'Login failed. Please try again.',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        duration: const Duration(seconds: 2),
      );
    }
  }

  bool validateForm() {
    if (employeeIdController.text.trim().isEmpty) {
      Get.snackbar(
        'Validation Error',
        'Please enter your employee ID',
        backgroundColor: Colors.orange,
        colorText: Colors.white,
        duration: const Duration(seconds: 2),
      );
      return false;
    }

    if (passwordController.text.trim().isEmpty) {
      Get.snackbar(
        'Validation Error',
        'Please enter your password',
        backgroundColor: Colors.orange,
        colorText: Colors.white,
        duration: const Duration(seconds: 2),
      );
      return false;
    }

    if (passwordController.text.trim().length < 6) {
      Get.snackbar(
        'Validation Error',
        'Password must be at least 6 characters',
        backgroundColor: Colors.orange,
        colorText: Colors.white,
        duration: const Duration(seconds: 2),
      );
      return false;
    }

    return true;
  }

  void togglePasswordVisibility() {
    obscurePassword = !obscurePassword;
    update();
  }

  @override
  void onClose() {
    employeeIdController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
