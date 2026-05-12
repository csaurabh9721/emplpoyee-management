import 'package:clientone_ess/shared/app_color.dart';
import 'package:clientone_ess/shared/components/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/change_password_controller.dart';

class ChangePasswordScreen extends StatelessWidget {
  ChangePasswordScreen({super.key});

  final ChangePasswordController controller = Get.put(ChangePasswordController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: controller.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: () => Get.back(),
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: AppColors.primaryDark.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: AppColors.primaryDark.withValues(alpha: 0.2),
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
              const SizedBox(height: 20),
              const Text(
                'Change Password',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              Text(
                'Update your account security by choosing a strong password.',
                style: TextStyle(
                  color: Colors.black.withValues(alpha: 0.7),
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              TextFormField(
                controller: controller.oldPasswordController,
                decoration: const InputDecoration(hintText: "Old Password"),
                validator: (v){
                  if(controller.oldPasswordController.text.isEmpty){
                    return "Please Enter Old Password";
                  }
                  if(controller.oldPasswordController.text.length < 4){
                    return "Must be 4 character";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: controller.newPasswordController,
                decoration: const InputDecoration(hintText: "New Password"),
                validator: (v){
                  if(controller.newPasswordController.text.isEmpty){
                    return "Please Enter New Password";
                  }
                  if(controller.newPasswordController.text.length < 4){
                    return "Must be 4 character";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: controller.confirmPasswordController,
                decoration: const InputDecoration(hintText: "Confirm Password"),
                validator: (v){
                  if(controller.confirmPasswordController.text.isEmpty){
                    return "Please Enter Confirm Password";
                  }
                  if(controller.confirmPasswordController.text.length < 4){
                    return "Must be 4 character";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 32),
              _PasswordStrengthIndicator(),
              const SizedBox(height: 32),
             Obx(()=> PrimaryButton(
               onTap: () {
                 if (controller.isLoading.value) return;
                 controller.changePassword();
               },
               child: controller.isLoading.value
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
             ),),
            ],
          ),
        ),
      ),
    );
  }
}

class _PasswordStrengthIndicator extends StatefulWidget {
  @override
  State<_PasswordStrengthIndicator> createState() => _PasswordStrengthIndicatorState();
}

class _PasswordStrengthIndicatorState extends State<_PasswordStrengthIndicator> {
  final ChangePasswordController _controller =  Get.find();
  final RxDouble _strength = 0.0.obs;
  @override
  void initState() {
    _controller.newPasswordController.addListener((){
      _strength.value = _calculatePasswordStrength(_controller.newPasswordController.text);
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Obx(
       () {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Password Strength',
              style: TextStyle(
                color: Colors.black,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 8),
            Container(
              height: 6,
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(3),
              ),
              child: FractionallySizedBox(
                alignment: Alignment.centerLeft,
                widthFactor: _strength.value,
                child: Container(
                  decoration: BoxDecoration(
                    color: _getStrengthColor(_strength.value),
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              _getStrengthText(_strength.value),
              style: TextStyle(
                color: _getStrengthColor(_strength.value),
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
    if (strength == 0.0) return '';
    if (strength <= 0.25) return 'Weak';
    if (strength <= 0.5) return 'Fair';
    if (strength <= 0.75) return 'Good';
    return 'Strong';
  }
}

