import 'package:flutter/material.dart';


class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.editingController,
    this.validation,
    this.hintText,
    this.maxLength,
    this.keyboardType,
    this.onChange,
    this.readOnly,
    this.suffixIcon,
    this.onTap,
    this.obscureText = false,
  });
  final TextEditingController editingController;
  final FormFieldValidator<String>? validation;
  final String? hintText;
  final int? maxLength;
  final TextInputType? keyboardType;
  final Function(String)? onChange;
  final Function()? onTap;
  final bool? readOnly;
  final Widget? suffixIcon;
 final bool obscureText ;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validation ??
          (v) {
            return null;
          },
      readOnly: readOnly ?? false,
      controller: editingController,
      maxLength: maxLength ?? 225,
      obscureText: obscureText,
      keyboardType: keyboardType ?? TextInputType.text,
      decoration: InputDecoration(
        hintText: hintText ?? "",
        counterText: "",
        suffixIcon: suffixIcon,
      ),
      onChanged: onChange ?? (v) {},
      onTap: onTap,
    );
  }
}
