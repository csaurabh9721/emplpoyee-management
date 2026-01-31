import 'package:flutter/material.dart';


class AppBarWidget extends StatelessWidget implements PreferredSizeWidget  {

  const AppBarWidget({super.key,
    required this.title,
    this.actions,
    this.isBackButton,
    this.onTap
  });
  final String title;
  final List<Widget>? actions;
  final bool? isBackButton;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return  AppBar(
      centerTitle: true,
      // leading: isBackButton != null
      //     ?  const BackButton(
      //   color: AppColors.background,
      // )
      //     : const SizedBox(),
      title: Text(
        title,
      ),
      actions: actions,

    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(56.0);
}
