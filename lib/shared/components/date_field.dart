import 'package:flutter/material.dart';
import 'package:clientone_ess/core/utils/validations.dart';

class DateField extends StatelessWidget {
  const DateField({super.key, required this.onTap, required this.controller});
  final VoidCallback onTap;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: true,
      onTap: onTap,
      decoration: const InputDecoration(
        // hintText: "dd/MM/yyyy",
        suffixIcon: Icon(Icons.calendar_today),
      ),
      validator: Validators.selectDate,
      controller: controller,
    );
  }
}
