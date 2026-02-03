import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../main.dart';
import '../bloc/landing_bloc.dart';
import 'dashboard_screen.dart';

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
        Widget bodyContent;
        if (state is LandingLoading || state is LandingInitial) {
          bodyContent = const Center(child: CircularProgressIndicator());
        } else if (state is LandingError) {
          bodyContent = Center(child: Text(state.message));
        } else if (state is LandingSuccess) {
          bodyContent = const DashboardView();
        } else {
          bodyContent = const SizedBox(); // fallback
        }
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              "DashbOard",
            ),
          ),
          body: bodyContent,
        );
      },
    );
  }
}
