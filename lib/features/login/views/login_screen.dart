import 'package:clientone_ess/shared/constants/png_images.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/routes/routes_name.dart';
import '../../../shared/app_color.dart';
import '../controllers/login_controller.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final LoginController controller = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: AppColors.splashGradient,
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _LogoSection(),
                  const SizedBox(height: 40),
                  _LoginCard(),
                  const SizedBox(height: 20),
                  _ForgotPasswordLink(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _LogoSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(
          PngImages.logo, // update if needed
          width: 140,
          height: 140,
        ),
        const Text(
          'Employee Portal',
          style: TextStyle(
            color: Colors.white,
            fontSize: 26,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 6),
        const Text(
          'Sign in to your account',
          style: TextStyle(
            color: Colors.white70,
            fontSize: 14,
          ),
        ),
      ],
    );
  }
}

class _LoginCard extends StatelessWidget {
  final LoginController controller = Get.find<LoginController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const Text(
              'Welcome Back',
              style: TextStyle(
                color: AppColors.textPrimary,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 24),
            _EmployeeIdField(),
            const SizedBox(height: 16),
            _PasswordField(),
            const SizedBox(height: 24),
            _LoginButton(),
          ],
        ),
      ),
    );
  }
}

class _EmployeeIdField extends StatelessWidget {
  final LoginController controller = Get.find<LoginController>();

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller.employeeIdController,
      decoration: InputDecoration(
        hintText: 'Employee ID',
        prefixIcon: const Icon(Icons.badge, color: AppColors.primary),
        filled: true,
        fillColor: Colors.grey.shade100,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}

class _PasswordField extends StatelessWidget {
  final LoginController controller = Get.find<LoginController>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(
      builder: (_) => TextFormField(
        controller: controller.passwordController,
        obscureText: controller.obscurePassword,
        decoration: InputDecoration(
          hintText: 'Password',
          prefixIcon: const Icon(Icons.lock, color: AppColors.primary),
          suffixIcon: IconButton(
            icon: Icon(
              controller.obscurePassword
                  ? Icons.visibility_off
                  : Icons.visibility,
              color: AppColors.textSecondary,
            ),
            onPressed: controller.togglePasswordVisibility,
          ),
          filled: true,
          fillColor: Colors.grey.shade100,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}

class _LoginButton extends GetView<LoginController> {
  @override
  Widget build(BuildContext context) {
    return Obx(
          () => SizedBox(
        width: double.infinity,
        height: 50,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          onPressed: () {
            if (controller.isLoading.value) return;
            if (controller.validateForm()) {
              controller.login();
            }
          },
          child: controller.isLoading.value
              ? const SizedBox(
            height: 20,
            width: 20,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              color: Colors.white,
            ),
          )
              : const Text(
            'Sign In',
            style: TextStyle(fontSize: 16),
          ),
        ),
      ),
    );
  }
}

class _ForgotPasswordLink extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        Get.toNamed(RoutesName.forgotPassword);
      },
      child: const Text(
        'Forgot your password?',
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}