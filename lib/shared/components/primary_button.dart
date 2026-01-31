import 'package:flutter/material.dart';
import 'package:clientone_ess/shared/app_color.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    this.label,
    this.width,
    this.height,
    required this.onTap,
    this.child,
    this.color,
  });
  final String? label;
  final double? width;
  final double? height;
  final VoidCallback onTap;
  final Widget? child;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height ?? 44,
      child: ElevatedButton(
        onPressed: onTap,
        style: Theme.of(context).elevatedButtonTheme.style?.copyWith(
              backgroundColor: WidgetStateProperty.all<Color>(
                color ?? AppColors.darkBlue,
              ),
            ),
        child: child ?? Text(label ?? "", textAlign: TextAlign.center),
      ),
    );
  }
}

class SecondaryButton extends StatelessWidget {
  const SecondaryButton({
    super.key,
    this.label,
    this.width,
    this.height,
    required this.onTap,
    this.child,
    this.color,
  });
  final String? label;
  final double? width;
  final double? height;
  final VoidCallback onTap;
  final Widget? child;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height ?? 44,
      child: ElevatedButton(
        onPressed: onTap,
        style: Theme.of(context).elevatedButtonTheme.style?.copyWith(
              elevation: WidgetStateProperty.all<double>(
                3,
              ),
              backgroundColor: WidgetStateProperty.all<Color>(
                AppColors.white,
              ),
              side: WidgetStateProperty.all<BorderSide>(
                const BorderSide(
                  color: AppColors.darkBlue,
                  width: 1,
                ),
              ),
            ),
        child: child ??
            Text(
              label ?? "",
              textAlign: TextAlign.center,
              style: const TextStyle(color: AppColors.darkBlue),
            ),
      ),
    );
  }
}

class PrimaryIconButton extends StatelessWidget {
  const PrimaryIconButton({
    super.key,
    this.label,
    this.width,
    this.height,
    required this.onTap,
    this.child,
    this.color,
    required this.icon,
  });
  final String? label;
  final double? width;
  final double? height;
  final VoidCallback onTap;
  final Widget? child;
  final Color? color;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height ?? 44,
      child: ElevatedButton.icon(
        onPressed: onTap,
        style: Theme.of(context).elevatedButtonTheme.style?.copyWith(
              backgroundColor: WidgetStateProperty.all<Color>(
                AppColors.darkBlue,
              ),
            ),
        icon: Icon(icon, color: AppColors.white),
        label: child ?? Text(label ?? "", textAlign: TextAlign.center),
      ),
    );
  }
}

class SecondaryIconButton extends StatelessWidget {
  const SecondaryIconButton({
    super.key,
    this.label,
    this.width,
    this.height,
    required this.onTap,
    this.child,
    this.color,
    required this.icon,
  });
  final String? label;
  final double? width;
  final double? height;
  final VoidCallback onTap;
  final Widget? child;
  final Color? color;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height ?? 44,
      child: ElevatedButton.icon(
        onPressed: onTap,
        style: Theme.of(context).elevatedButtonTheme.style?.copyWith(
              elevation: WidgetStateProperty.all<double>(
                3,
              ),
              backgroundColor: WidgetStateProperty.all<Color>(
                AppColors.white,
              ),
              side: WidgetStateProperty.all<BorderSide>(
                const BorderSide(
                  color: AppColors.darkBlue,
                  width: 1,
                ),
              ),
            ),
        icon: Icon(icon, color: AppColors.darkBlue),
        label: child ??
            Text(
              label ?? "",
              textAlign: TextAlign.center,
              style: const TextStyle(color: AppColors.darkBlue),
            ),
      ),
    );
  }
}
