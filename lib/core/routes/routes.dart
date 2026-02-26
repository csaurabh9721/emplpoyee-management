

import 'package:get/get.dart';
import '../../features/dashboard/views/dashboard_screen.dart';
import '../../features/leaveManagementPage/view/leave_management_page.dart';
import '../../features/payslip/paySlipHistory/view/pay_slip_history.dart';
import '../../features/payslip/payslipDetail/view/payslip_detail_screen.dart';
import 'routes_name.dart';

class AppRoutes {
  static final routes = [
    GetPage(
      name: RoutesName.dashboard,
      page: () =>  DashboardScreen(),
    ),

    GetPage(
      name: RoutesName.leaveManagementPage,
      page: () =>  LeaveManagementPage(),
    ),

    GetPage(
      name: RoutesName.payslipHistory,
      page: () =>  PayslipHistoryPage(),
    ),

    GetPage(
      name: RoutesName.payslipDetail,
      page: () =>  PayslipDetailScreen(),
    ),
  ];
}
