import 'package:get/get.dart';
import '../../features/attendance/views/attendance_screen.dart';
import '../../features/accountBalance/views/account_balance_screen.dart';
import '../../features/accountBalance/views/account_detail_screen.dart';
import '../../features/dashboard/views/dashboard_screen.dart';
import '../../features/login/views/login_screen.dart';
import '../../features/splash/views/splash_screen.dart';
import '../../features/leaveApply/view/apply_leave_page.dart';
import '../../features/leaveHistory/view/leave_history_screen.dart';
import '../../features/leaveManagementPage/view/leave_management_page.dart';
import '../../features/payslip/paySlipHistory/view/pay_slip_history.dart';
import '../../features/payslip/payslipDetail/view/payslip_detail_screen.dart';
import '../../features/profile/views/profile_screen.dart';
import '../../features/profile/views/edit_profile_screen.dart';
import '../../features/forgetPassword/views/forget_password_screen.dart';
import '../../features/changePassword/views/change_password_screen.dart';
import '../../features/leaveApproval/views/leave_approval_screen.dart';
import '../../features/teamAttendance/views/team_attendance_screen.dart';
import 'routes_name.dart';

class AppRoutes {
  static final routes = [
    GetPage(
      name: RoutesName.splash,
      page: () => const SplashScreen(),
    ),
    GetPage(
      name: RoutesName.login,
      page: () => LoginScreen(),
    ),
    GetPage(
      name: RoutesName.dashboard,
      page: () => DashboardScreen(),
    ),
    GetPage(
      name: RoutesName.attendance,
      page: () => const AttendanceScreen(),
    ),
    GetPage(
      name: RoutesName.teamAttendance,
      page: () => const TeamAttendanceScreen(),
    ),
    GetPage(
      name: RoutesName.accountBalance,
      page: () => const AccountBalanceScreen(),
    ),
    GetPage(
      name: '${RoutesName.accountDetail}/:id',
      page: () => const AccountDetailScreen(),
    ),
    GetPage(
      name: RoutesName.leaveManagementPage,
      page: () => LeaveManagementPage(),
    ),
    GetPage(
      name: RoutesName.payslipHistory,
      page: () => const PayslipHistoryPage(),
    ),
    GetPage(
      name: RoutesName.payslipDetail,
      page: () => const PayslipDetailScreen(),
    ),
    GetPage(
      name: RoutesName.applyLeavePage,
      page: () => const ApplyLeavePage(),
    ),
    GetPage(
      name: RoutesName.leaveHistoryScreen,
      page: () => const LeaveHistoryScreen(),
    ),
    GetPage(
      name: RoutesName.profile,
      page: () => ProfileScreen(),
    ),
    GetPage(
      name: RoutesName.editProfile,
      page: () => EditProfileScreen(),
    ),
    GetPage(
      name: RoutesName.forgotPassword,
      page: () => ForgetPasswordScreen(),
    ),
    GetPage(
      name: RoutesName.changePassword,
      page: () => ChangePasswordScreen(),
    ),
    GetPage(
      name: RoutesName.leaveApproval,
      page: () => LeaveApprovalScreen(),
    ),
  ];
}
