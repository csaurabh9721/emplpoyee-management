import 'package:flutter/material.dart';

import '../../../../shared/app_color.dart';

class ProfileBuildRow extends StatelessWidget {

  const ProfileBuildRow(
    this.label,
    this.value, {
    super.key,
  });
  final String label, value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      child: Row(
        spacing: 20,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
              child: Text(
            label,
                style: Theme.of(context).textTheme.titleSmall!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
          ),),
          Expanded(
            flex: 2,
            child: Text(
              value,
              style: Theme.of(context).textTheme.titleMedium!.copyWith(color: AppColors.grey700),
            ),
          ),
        ],
      ),
    );
  }
}
