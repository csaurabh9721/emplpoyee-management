import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:clientone_ess/core/routes/routes_name.dart';
import 'package:clientone_ess/shared/app_color.dart';
import 'package:clientone_ess/shared/components/snackbar.dart';
import 'package:clientone_ess/shared/constants/app_strings.dart';

import '../../../../core/service/sessionManagement/sessions.dart';
import '../../../../shared/constants/png_images.dart';
import '../../domain/entity/user_login_entity.dart';
import '../loginBloc/login_bloc.dart';
import '../loginBloc/toggle_password_cubit.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _employeeCodeController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    _employeeCodeController.text = Sessions.getEmployeeCode();
    super.initState();
  }

  @override
  void dispose() {
    _employeeCodeController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: size.height,
          padding: const EdgeInsets.all(16),
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(PngImages.loginBg),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: size.height * 0.4),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Icon(Icons.person, size: 60, color: AppColors.lightBlue),
                    SizedBox(width: 20),
                    Text(
                      AppString.login,
                      style: TextStyle(
                          color: AppColors.white,
                          fontSize: 25,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    _buildInputField(
                      label: AppString.employeeCode,
                      controller: _employeeCodeController,
                    ),
                    const SizedBox(height: 20),
                    BlocBuilder<TogglePasswordCubit, TogglePasswordState>(
                      builder: (context, state) {
                        return _buildInputField(
                          label: AppString.password,
                          isVisible: state.isVisible,
                          controller: _passwordController,
                        );
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, RoutesName.forgetPassword);
                  },
                  child: const Text(
                    'Forgot Password',
                    style: TextStyle(color: AppColors.white),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Center(
                child: BlocConsumer<LoginBloc, LoginState>(
                  listener: (context, state) {
                    if (state is LoginSuccess) {
                      AppSnackBar.successSnackBar(
                          message: state.successMessage);
                      Navigator.pushReplacementNamed(
                          context, RoutesName.landingPage);
                    }
                    if (state is LoginError) {
                      AppSnackBar.errorSnackBar(message: state.errorMessage);
                    }
                  },
                  builder: (context, state) {
                    if (state is LoginLoading) {
                      return const CircularProgressIndicator(
                        color: AppColors.white,
                      );
                    }
                    return SizedBox(
                      height: 45,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.white,
                          foregroundColor: AppColors.snackbarBackground,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            context.read<LoginBloc>().add(LoginButtonPressed(
                                  userLoginEntity: UserLoginEntity(
                                    code: _employeeCodeController.text.trim(),
                                    password: _passwordController.text.trim(),
                                  ),
                                ));
                          }
                        },
                        child: const Text(
                          AppString.login,
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Row _buildInputField({
    required String label,
    bool? isVisible,
    required TextEditingController controller,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          flex: 1,
          child: Text(
            label,
            style: const TextStyle(color: AppColors.white, fontSize: 15),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          flex: 2,
          child: TextFormField(
            controller: controller,
            obscureText: isVisible != null ? !isVisible : false,
            style: const TextStyle(color: Colors.black),
            cursorColor: Colors.black,
            keyboardType:
                isVisible != null ? TextInputType.text : TextInputType.number,
            inputFormatters: isVisible != null
                ? []
                : [FilteringTextInputFormatter.digitsOnly],
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return '$label is required';
              }
              if (isVisible == null &&
                  !RegExp(r'^\d+$').hasMatch(value.trim())) {
                return '$label must be numeric';
              }
              return null;
            },
            decoration: InputDecoration(
              filled: true,
              fillColor: AppColors.white,
              hintStyle: const TextStyle(color: Colors.white60),
              suffixIcon: isVisible != null
                  ? InkWell(
                      onTap: () {
                        context
                            .read<TogglePasswordCubit>()
                            .togglePasswordVisibility();
                      },
                      child: Icon(
                          isVisible
                              ? Icons.remove_red_eye
                              : Icons.visibility_off,
                          color: AppColors.snackbarBackground),
                    )
                  : null,
              enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white70),
              ),
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
              ),
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
            ),
          ),
        ),
      ],
    );
  }
}
