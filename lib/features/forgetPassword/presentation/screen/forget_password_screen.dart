import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:clientone_ess/core/utils/date_formatter.dart';
import 'package:clientone_ess/core/utils/validations.dart';
import 'package:clientone_ess/main.dart';
import 'package:clientone_ess/shared/app_color.dart';
import 'package:clientone_ess/shared/constants/app_strings.dart';

import '../../../../shared/components/date_field.dart';
import '../../../../shared/constants/png_images.dart';
import '../cubit/forget_password_cubit.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _employeeCodeController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  DateTime _dateTime = DateTime(2000);

  @override
  void dispose() {
    _employeeCodeController.dispose();
    _dateController.dispose();
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
                      AppString.forgotYourPassword,
                      style: TextStyle(
                          color: AppColors.white,
                          fontSize: 22,
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
                    _buildRow(
                      AppString.employeeCode,
                      child: TextFormField(
                        controller: _employeeCodeController,
                        validator: Validators.notEmpty,
                      ),
                    ),
                    const SizedBox(height: 20),
                    _buildRow(
                      "DOB",
                      child: DateField(
                        controller: _dateController,
                        onTap: _pickDate,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              Center(
                child: BlocConsumer<ForgetPasswordCubit, ForgetPasswordState>(
                  listener: (context, state) async {
                    if (state is SuccessState) {
                      final bool res = await _successDialog(
                        context,
                        state.successMessage,
                      );
                      if (res) {
                        Navigator.of(navigatorKey.currentContext!).pop();
                      }
                    }
                    if (state is ErrorState) {
                      _errorDialog(state.errorMessage);
                    }
                  },
                  builder: (context, state) {
                    if (state is LoadingState) {
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
                            context
                                .read<ForgetPasswordCubit>()
                                .callForgetPassword(
                                    _employeeCodeController.text,
                                    _dateTime.ddMmYyyy());
                          }
                        },
                        child: const Text(
                          AppString.reset,
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

  Row _buildRow(String title, {required Widget child}) {
    return Row(
      children: [
        Expanded(
            flex: 1,
            child: Text(
              title,
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(color: AppColors.white),
            )),
        Expanded(
          flex: 2,
          child: child,
        ),
      ],
    );
  }

  void _pickDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _dateTime,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      _dateTime = picked;
      _dateController.text = picked.ddMonthYYYY();
    }
  }

  Future<bool> _successDialog(
    BuildContext context,
    String message,
  ) async {
    return await showDialog(
          context: context,
          builder: (BuildContext context) {
            return Dialog(
              insetPadding: const EdgeInsets.all(20),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const SizedBox(),
                        GestureDetector(
                          onTap: () => Navigator.of(context).pop(true),
                          child: const Icon(Icons.close, color: Colors.black),
                        ),
                      ],
                    ),
                    const Icon(
                      Icons.check_circle,
                      color: AppColors.green,
                      size: 60,
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      "Password Reset Successfully",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: AppColors.green,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      message,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 16,
                        color: AppColors.snackbarBackground,
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            );
          },
        ) ??
        true;
  }

  void _errorDialog(String message) {
    showDialog(
      context: navigatorKey.currentContext!,
      //  barrierDismissible: false, // prevent dismiss on tap outside
      builder: (BuildContext context) {
        return Dialog(
          insetPadding: const EdgeInsets.all(20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(),
                    GestureDetector(
                      onTap: () => Navigator.of(context).pop(),
                      child: const Icon(Icons.close, color: Colors.black),
                    ),
                  ],
                ),
                const Icon(
                  Icons.cancel,
                  color: AppColors.error,
                  size: 60,
                ),
                const SizedBox(height: 4),
                const Text(
                  "Password Reset Failed",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: AppColors.error,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  message,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 16,
                    color: AppColors.snackbarBackground,
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        );
      },
    );
  }
}
