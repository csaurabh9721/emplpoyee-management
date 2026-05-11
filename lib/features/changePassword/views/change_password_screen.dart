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
      backgroundColor: const Color(0xFF0F172A),
      body: GradientBackground(
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 20),
                _HeaderSection(),
                const SizedBox(height: 40),
                _ChangePasswordCard(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class GradientBackground extends StatelessWidget {
  final Widget child;
  
  const GradientBackground({super.key, required this.child});
  
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF0F172A),
            Color(0xFF1E293B),
            Color(0xFF334155),
          ],
        ),
      ),
      child: child,
    );
  }
}

class _HeaderSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            GestureDetector(
              onTap: () => Get.back(),
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.2),
                  ),
                ),
                child: const Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 30),
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.2),
            ),
          ),
          child: const Icon(
            Icons.lock_reset,
            size: 60,
            color: Color(0xFF60A5FA),
          ),
        ),
        const SizedBox(height: 20),
        const Text(
          'Change Password',
          style: TextStyle(
            color: Colors.white,
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 12),
        Text(
          'Update your account security by choosing a strong password.',
          style: TextStyle(
            color: Colors.white.withValues(alpha: 0.7),
            fontSize: 16,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

class _ChangePasswordCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.1),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const _PasswordField(
              label: 'Current Password',
              hint: 'Enter your current password',
              isOld: true,
            ),
            const SizedBox(height: 24),
            const _PasswordField(
              label: 'New Password',
              hint: 'Create a strong password',
              isNew: true,
            ),
            const SizedBox(height: 24),
            const _PasswordField(
              label: 'Confirm New Password',
              hint: 'Re-type your new password',
              isConfirm: true,
            ),
            const SizedBox(height: 32),
            _PasswordStrengthIndicator(),
            const SizedBox(height: 32),
            _SubmitButton(),
          ],
        ),
      ),
    );
  }
}

class _PasswordField extends StatefulWidget {
  final String label;
  final String hint;
  final bool isOld;
  final bool isNew;
  final bool isConfirm;
  
  const _PasswordField({
    required this.label,
    required this.hint,
    this.isOld = false,
    this.isNew = false,
    this.isConfirm = false,
  });
  
  @override
  State<_PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<_PasswordField> {
  final ChangePasswordController controller = Get.find<ChangePasswordController>();
  bool _isFocused = false;
  
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              widget.label,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            if (widget.isNew) ...[
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFF60A5FA).withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: const Text(
                  'Required',
                  style: TextStyle(
                    color: Color(0xFF60A5FA),
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ],
        ),
        const SizedBox(height: 12),
        FocusScope(
          onFocusChange: (hasFocus) {
            setState(() {
              _isFocused = hasFocus;
            });
          },
          child: GetBuilder<ChangePasswordController>(
            builder: (_) {
              final bool obscure = widget.isOld
                  ? controller.obscureOldPassword
                  : (widget.isNew ? controller.obscureNewPassword : controller.obscureConfirmPassword);
              final TextEditingController textController = widget.isOld
                  ? controller.oldPasswordController
                  : (widget.isNew ? controller.newPasswordController : controller.confirmPasswordController);
              final VoidCallback toggleVisibility = widget.isOld
                  ? controller.toggleOldPasswordVisibility
                  : (widget.isNew ? controller.toggleNewPasswordVisibility : controller.toggleConfirmPasswordVisibility);

              return Container(
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: _isFocused
                        ? const Color(0xFF60A5FA).withValues(alpha: 0.5)
                        : Colors.white.withValues(alpha: 0.2),
                    width: _isFocused ? 2 : 1,
                  ),
                ),
                child: TextFormField(
                  controller: textController,
                  obscureText: obscure,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                  decoration: InputDecoration(
                    hintText: widget.hint,
                    hintStyle: TextStyle(
                      color: Colors.white.withValues(alpha: 0.5),
                      fontSize: 16,
                    ),
                    prefixIcon: Icon(
                      widget.isOld ? Icons.lock_outline : Icons.lock,
                      color: _isFocused ? const Color(0xFF60A5FA) : Colors.white.withValues(alpha: 0.6),
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        obscure ? Icons.visibility_off : Icons.visibility,
                        color: Colors.white.withValues(alpha: 0.6),
                      ),
                      onPressed: toggleVisibility,
                    ),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class _PasswordStrengthIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ChangePasswordController>(
      builder: (controller) {
        final password = controller.newPasswordController.text;
        final strength = _calculatePasswordStrength(password);
        
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Password Strength',
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 8),
            Container(
              height: 6,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(3),
              ),
              child: FractionallySizedBox(
                alignment: Alignment.centerLeft,
                widthFactor: strength,
                child: Container(
                  decoration: BoxDecoration(
                    color: _getStrengthColor(strength),
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              _getStrengthText(strength),
              style: TextStyle(
                color: _getStrengthColor(strength),
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        );
      },
    );
  }
  
  double _calculatePasswordStrength(String password) {
    if (password.isEmpty) return 0.0;
    
    double strength = 0.0;
    
    if (password.length >= 8) strength += 0.25;
    if (password.length >= 12) strength += 0.25;
    if (password.contains(RegExp(r'[A-Z]'))) strength += 0.25;
    if (password.contains(RegExp(r'[0-9]'))) strength += 0.125;
    if (password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) strength += 0.125;
    
    return strength.clamp(0.0, 1.0);
  }
  
  Color _getStrengthColor(double strength) {
    if (strength <= 0.25) return const Color(0xFFEF4444);
    if (strength <= 0.5) return const Color(0xFFF59E0B);
    if (strength <= 0.75) return const Color(0xFF60A5FA);
    return const Color(0xFF10B981);
  }
  
  String _getStrengthText(double strength) {
    if (strength == 0.0) return 'Enter a password';
    if (strength <= 0.25) return 'Weak';
    if (strength <= 0.5) return 'Fair';
    if (strength <= 0.75) return 'Good';
    return 'Strong';
  }
}

class _SubmitButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ChangePasswordController>(
      builder: (controller) => AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        child: ElevatedButton(
          onPressed: controller.changePasswordResponse.status == ApiStatus.loading
              ? null
              : () => controller.changePassword(),
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF60A5FA),
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 18),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 0,
            shadowColor: const Color(0xFF60A5FA).withValues(alpha: 0.3),
          ),
          child: controller.changePasswordResponse.status == ApiStatus.loading
              ? const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(width: 12),
                    Text(
                      'Updating...',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                )
              : const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.lock_reset,
                      size: 20,
                    ),
                    SizedBox(width: 12),
                    Text(
                      'Update Password',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
