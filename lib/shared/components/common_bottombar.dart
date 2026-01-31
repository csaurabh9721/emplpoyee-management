import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/routes/routes_name.dart';
import '../../features/landing/presentation/bloc/landing_bloc.dart';
import '../app_color.dart';

class CommonBottomBar extends StatelessWidget {

  const CommonBottomBar({super.key, this.isFromLandingPage = false});
  final bool isFromLandingPage;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LandingBloc, LandingState>(
      builder: (context, state) {
        final int index = isFromLandingPage ? state.currentIndex : 3;
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
                  context.read<LandingBloc>().add(const LandingPageChangeEvent(0));
                },
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.home, color: index == 0 ? AppColors.primary : null),
                    Text('Home',style:TextStyle(color: index == 0 ? AppColors.primary : null)),
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
                  context.read<LandingBloc>().add(const LandingPageChangeEvent(1));
                },
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.person , color: index == 1 ? AppColors.primary : null),
                    Text('Profile', style:TextStyle(color: index == 1 ? AppColors.primary : null)),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
