import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/Enums/enums.dart';
import '../controllers/change_password_controller.dart';

class ChangePasswordScreen extends StatelessWidget {
  ChangePasswordScreen({super.key});
  final ChangePasswordController controller = Get.put(ChangePasswordController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6FA),
      appBar: AppBar(
        title: const Text(
          'Change Password',
          style: TextStyle(color: Color(0xFF2C3E50), fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF2C3E50)),
          onPressed: () => Get.back(),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Update your account security by choosing a strong password.',
                style: TextStyle(
                  color: Color(0xFF7F8C8D),
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              _ChangePasswordCard(),
            ],
          ),
        ),
      ),
    );
  }
}

class _ChangePasswordCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _PasswordField(
              label: 'Old Password',
              hint: 'Enter current password',
              isOld: true,
            ),
            const SizedBox(height: 20),
            _PasswordField(
              label: 'New Password',
              hint: 'Enter new password',
              isNew: true,
            ),
            const SizedBox(height: 20),
            _PasswordField(
              label: 'Confirm New Password',
              hint: 'Re-type new password',
              isConfirm: true,
            ),
            const SizedBox(height: 32),
            _SubmitButton(),
          ],
        ),
      ),
    );
  }
}

class _PasswordField extends StatelessWidget {
  final String label;
  final String hint;
  final bool isOld;
  final bool isNew;
  final bool isConfirm;
  final ChangePasswordController controller = Get.find<ChangePasswordController>();

  _PasswordField({
    required this.label,
    required this.hint,
    this.isOld = false,
    this.isNew = false,
    this.isConfirm = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Color(0xFF2C3E50),
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        GetBuilder<ChangePasswordController>(
          builder: (_) {
            final bool obscure = isOld
                ? controller.obscureOldPassword
                : (isNew ? controller.obscureNewPassword : controller.obscureConfirmPassword);
            final TextEditingController textController = isOld
                ? controller.oldPasswordController
                : (isNew ? controller.newPasswordController : controller.confirmPasswordController);
            final VoidCallback toggleVisibility = isOld
                ? controller.toggleOldPasswordVisibility
                : (isNew ? controller.toggleNewPasswordVisibility : controller.toggleConfirmPasswordVisibility);

            return TextFormField(
              controller: textController,
              obscureText: obscure,
              style: const TextStyle(
                color: Color(0xFF2C3E50),
                fontSize: 14,
              ),
              decoration: InputDecoration(
                hintText: hint,
                hintStyle: const TextStyle(
                  color: Color(0xFF95A5A6),
                  fontSize: 14,
                ),
                prefixIcon: const Icon(
                  Icons.lock,
                  color: Color(0xFF3498DB),
                ),
                suffixIcon: IconButton(
                  icon: Icon(
                    obscure ? Icons.visibility_off : Icons.visibility,
                    color: const Color(0xFF7F8C8D),
                  ),
                  onPressed: toggleVisibility,
                ),
                filled: true,
                fillColor: const Color(0xFFF8F9FA),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Color(0xFFE0E0E0), width: 1),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Color(0xFF3498DB), width: 2),
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              ),
            );
          },
        ),
      ],
    );
  }
}

class _SubmitButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ChangePasswordController>(
      builder: (controller) => ElevatedButton(
        onPressed: controller.changePasswordResponse.status == ApiStatus.loading
            ? null
            : () => controller.changePassword(),
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF3498DB),
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          elevation: 0,
        ),
        child: controller.changePasswordResponse.status == ApiStatus.loading
            ? const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: Colors.white,
                ),
              )
            : const Text(
                'Update Password',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
      ),
    );
  }
}
