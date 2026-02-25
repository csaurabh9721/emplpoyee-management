

import 'package:get/get.dart';
import '../../features/dashboard/views/dashboard_screen.dart';
import 'routes_name.dart';

class AppRoutes {
  static final routes = [
    GetPage(
      name: RoutesName.dashboard,
      page: () => const DashboardScreen(),
    ),
  ];
}
