import 'package:clientone_ess/core/routes/routes_name.dart';
import 'package:clientone_ess/core/service/sessionManagement/sessions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/utils/base_api_response.dart';
import '../models/login_model.dart';
import '../services/login_service.dart';

class LoginController extends GetxController {
  final LoginService _loginService = LoginService();

  // Form controllers
  final TextEditingController employeeIdController = TextEditingController(text: "user1@gmail.com");
  final TextEditingController passwordController = TextEditingController(text: "user1");

  // State management
  RxBool isLoading = false.obs;
  bool obscurePassword = true;

  Future<void> login() async {
    isLoading.value = true;
    try {
      final LoginRequest request = LoginRequest(
        emailId: employeeIdController.text.trim(),
        password: passwordController.text.trim(),
      );

      final LoginResponse response = await _loginService.login(request);
      isLoading.value = false;

      if (response.statusCode == 200) {
        update();
        Get.snackbar(
          'Success',
          response.message,
          backgroundColor: Colors.green,
          colorText: Colors.white,
          duration: const Duration(seconds: 2),
        );
        Sessions.setUserId(response.body!.userId);
        Sessions.setEmpName(response.body!.employeeName);
        Sessions.setEmployeeCode(response.body!.employeeCode);
        Sessions.setAccessToken(response.body!.accessToken);
        Sessions.setRefreshToken(response.body!.accessToken);
        Get.offAllNamed(RoutesName.dashboard);
      } else {
        throw Exception(response.message);
      }
    } catch (e) {
      Get.snackbar(
        'Login Failed',
        e.toString(),
        backgroundColor: Colors.red,
        colorText: Colors.white,
        duration: const Duration(seconds: 3),
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

    if (passwordController.text.trim().length < 4) {
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
