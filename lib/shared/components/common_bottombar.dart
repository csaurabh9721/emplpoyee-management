import 'package:flutter/material.dart';
import '../../core/routes/routes_name.dart';
import '../app_color.dart';

class CommonBottomBar extends StatelessWidget {

  const CommonBottomBar({super.key, this.isFromLandingPage = false});
  final bool isFromLandingPage;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white, // Add a background color to see the shadow
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, -3), // changes position of shadow (from the top)
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          InkWell(
            onTap: () {
              if (!isFromLandingPage) {
                debugPrint("Until Pop is called...");
                Navigator.pushNamedAndRemoveUntil(
                    context, RoutesName.landingPage, (route) => false);
              }
            },
            child: const Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.home, color: AppColors.primary ),
                Text('Home',style:TextStyle(color: AppColors.primary)),
              ],
            ),
          ),
          InkWell(
            onTap: () {
              if (!isFromLandingPage) {
                debugPrint("Until Pop is called...");
                Navigator.pushNamedAndRemoveUntil(
                    context, RoutesName.landingPage, (route) => false);
              }
            },
            child: const Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.person , color: AppColors.primary ),
                Text('Profile', style:TextStyle(color: AppColors.primary)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
