import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:clientone_ess/features/landing/presentation/screens/profile_screen.dart';

import '../../../../main.dart';
import '../../../../shared/components/common_bottombar.dart';
import '../../domain/entity/dashboard_response_entity.dart';
import '../../domain/entity/profile_entity.dart';
import '../bloc/landing_bloc.dart';
import 'dashboard_screen.dart';
import 'drawer.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> with RouteAware {
  @override
  void initState() {
    super.initState();
    context.read<LandingBloc>().add(const LoadAllDataEvent());
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)! as PageRoute);
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }

  @override
  void didPopNext() {
    context.read<LandingBloc>().add(const RefreshDashboard());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LandingBloc, LandingState>(
      builder: (context, state) {
        final currentIndex = state.currentIndex;
        List<AppDashboardRoutes> routes = [];
        ProfileResponseEntity? profileData;
        Widget bodyContent;
        if (state is LandingLoading || state is LandingInitial) {
          bodyContent = const Center(child: CircularProgressIndicator());
        } else if (state is LandingError) {
          bodyContent = Center(child: Text(state.message));
        } else if (state is LandingSuccess) {
          routes = state.dahBoardData.getRightForDrawer;
          profileData = state.profileData;
          bodyContent = _buildPage(currentIndex,
              dashboardData: state.dahBoardData,
              profileData: state.profileData);
        } else {
          bodyContent = const SizedBox(); // fallback
        }
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              state.appBarTitle,
            ),
          ),
          drawer: DrawerWidget(
            routes: routes,
            profileData: profileData,
          ),
          body: bodyContent,
          bottomNavigationBar: const CommonBottomBar(isFromLandingPage: true),
        );
      },
    );
  }

  Widget _buildPage(int index,
      {required DashboardResponseEntity dashboardData,
      required ProfileResponseEntity profileData}) {
    switch (index) {
      case 0:
        return DashboardView(
            dashboardData: dashboardData, profileData: profileData);
      case 1:
        return ProfileView(profileData: profileData);
      default:
        return const Center(child: Text('Invalid tab'));
    }
  }
}
