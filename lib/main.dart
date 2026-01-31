import 'package:clientone_ess/shared/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';

import 'core/dependencyInjection/di.dart';
import 'core/routes/routes.dart';
import 'core/routes/routes_name.dart';
import 'features/landing/domain/useCases/dashboard_usecase.dart';
import 'features/landing/domain/useCases/get_profile_usecase.dart';
import 'features/landing/presentation/bloc/landing_bloc.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  setupDependencyInjection();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LandingBloc(
        di<DashboardUseCaseImpl>(),
        di<GetProfileUseCaseImpl>(),
      ),
      child: SafeArea(
        bottom: true,
        top: false,
        child: MaterialApp(
          title: "JILIT ESS",
          debugShowCheckedModeBanner: false,
          navigatorKey: navigatorKey,
          theme: AppTheme.lightTheme,
          initialRoute: RoutesName.splash,
          onGenerateRoute: AppRoutes.generateRoute,
          navigatorObservers: [MyNavigatorObserver(), routeObserver],
        ),
      ),
    );
  }
}

final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();

class MyNavigatorObserver extends NavigatorObserver {
  @override
  void didPush(Route route, Route? previousRoute) {
    super.didPush(route, previousRoute);
    debugPrint('🟢 Pushed: ${route.settings.name}');
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    super.didPop(route, previousRoute);
    debugPrint('🔴 Popped: ${route.settings.name}');
  }

  @override
  void didReplace({Route? newRoute, Route? oldRoute}) {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
    debugPrint(
        '🟡 Replaced: ${oldRoute?.settings.name} → ${newRoute?.settings.name}');
  }
}
