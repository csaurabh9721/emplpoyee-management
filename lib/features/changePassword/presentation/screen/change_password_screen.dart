import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:clientone_ess/core/utils/validations.dart';
import 'package:clientone_ess/shared/app_color.dart';
import 'package:clientone_ess/shared/components/primary_button.dart';
import 'package:clientone_ess/shared/components/snackbar.dart';
import 'package:clientone_ess/shared/constants/app_strings.dart';

import '../../../../shared/components/appbar.dart';
import '../../../../shared/components/header.dart' show Header;
import '../cubit/change_password_cubit.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _oldPassword = TextEditingController();
  final TextEditingController _newPassword = TextEditingController();
  final TextEditingController _confirmPassword = TextEditingController();

  final StreamController<bool> _oldPasswordVisible = StreamController<bool>();
  final StreamController<bool> _newPasswordVisible = StreamController<bool>();
  final StreamController<bool> _confirmPasswordVisible =
      StreamController<bool>();

  @override
  void dispose() {
    _oldPassword.dispose();
    _newPassword.dispose();
    _confirmPassword.dispose();
    _oldPasswordVisible.close();
    _newPasswordVisible.close();
    _confirmPasswordVisible.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(title: "Change Password"),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Header(
            child: Column(
              children: [
                StreamBuilder(
                    stream: _oldPasswordVisible.stream,
                    initialData: false,
                    builder: (context, AsyncSnapshot<bool> snapshot) {
                      final bool isVisible = snapshot.data!;
                      return _buildRow(
                        AppString.oldPassword,
                        child: TextFormField(
                          obscureText: !isVisible,
                          controller: _oldPassword,
                          validator: Validators.password,
                          decoration: InputDecoration(
                            suffixIcon: InkWell(
                              onTap: () {
                                _oldPasswordVisible.add(!isVisible);
                              },
                              child: Icon(
                                  isVisible
                                      ? Icons.remove_red_eye
                                      : Icons.visibility_off,
                                  color: AppColors.snackbarBackground),
                            ),
                          ),
                        ),
                      );
                    }),
                const SizedBox(height: 20),
                StreamBuilder(
                    stream: _newPasswordVisible.stream,
                    initialData: false,
                    builder: (context, AsyncSnapshot<bool> snapshot) {
                      final bool isVisible = snapshot.data!;
                      return _buildRow(
                        AppString.newPassword,
                        child: TextFormField(
                          controller: _newPassword,
                          obscureText: !isVisible,
                          validator: Validators.password,
                          decoration: InputDecoration(
                            suffixIcon: InkWell(
                              onTap: () {
                                _newPasswordVisible.add(!isVisible);
                              },
                              child: Icon(
                                  isVisible
                                      ? Icons.remove_red_eye
                                      : Icons.visibility_off,
                                  color: AppColors.snackbarBackground),
                            ),
                          ),
                        ),
                      );
                    }),
                const SizedBox(height: 20),
                StreamBuilder<bool>(
                  stream: _confirmPasswordVisible.stream,
                  initialData: false,
                  builder: (context, AsyncSnapshot<bool> snapshot) {
                    final bool isVisible = snapshot.data!;
                    return _buildRow(
                      AppString.changePassword,
                      child: TextFormField(
                        obscureText: !isVisible,
                        controller: _confirmPassword,
                        validator: (v) =>
                            Validators.confirmPassword(v, _newPassword.text),
                        decoration: InputDecoration(
                          suffixIcon: InkWell(
                            onTap: () {
                              _confirmPasswordVisible.add(!isVisible);
                            },
                            child: Icon(
                                isVisible
                                    ? Icons.remove_red_eye
                                    : Icons.visibility_off,
                                color: AppColors.snackbarBackground),
                          ),
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 30),
                Center(
                  child: BlocConsumer<ChangePasswordCubit, ChangePasswordState>(
                    listener: (context, state) {
                      if (state is SuccessState) {
                        Navigator.pop(context);
                        AppSnackBar.successSnackBar(
                            message: state.successMessage);
                      }
                      if (state is ErrorState) {
                        AppSnackBar.errorSnackBar(message: state.errorMessage);
                      }
                    },
                    builder: (context, state) {
                      if (state is LoadingState) {
                        return const CircularProgressIndicator(
                          color: AppColors.primary,
                        );
                      }
                      return SizedBox(
                        height: 45,
                        child: PrimaryButton(
                          onTap: () async {
                            if (_formKey.currentState!.validate()) {
                              final cubit = context.read<ChangePasswordCubit>();
                              final bool res =
                                  await _showConfirmationDialog(context);

                              if (res) {
                                cubit.callChangePassword(
                                  _oldPassword.text,
                                  _newPassword.text,
                                  _confirmPassword.text,
                                );
                              }
                            }
                          },
                          label: AppString.reset,
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
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
              style: Theme.of(context).textTheme.titleMedium,
            )),
        Expanded(
          flex: 2,
          child: child,
        ),
      ],
    );
  }

  Future<bool> _showConfirmationDialog(BuildContext context) async {
    return await showDialog(
          context: context,
          builder: (context) {
            return Dialog(
              insetPadding: const EdgeInsets.all(12),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomCenter,
                        colors: [
                          Color(0x80E9EFFF),
                          Color(0x80A7B1E9),
                        ],
                      ),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10)),
                    ),
                    padding: const EdgeInsets.symmetric(
                        vertical: 12, horizontal: 16),
                    child: const Text('Confirmation',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16)),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text('Do you want to change your Password?'),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SecondaryButton(
                        width: 80,
                        height: 36,
                        onTap: () {
                          Navigator.of(context).pop(false);
                        },
                        label: "No",
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                      PrimaryButton(
                        width: 80,
                        height: 36,
                        color: AppColors.darkBlue,
                        onTap: () {
                          Navigator.of(context).pop(true);
                        },
                        label: "Yes",
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                ],
              ),
            );
          },
        ) ??
        false;
  }
}
