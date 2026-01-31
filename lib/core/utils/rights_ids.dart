import '../../features/landing/domain/entity/dashboard_response_entity.dart';
import '../routes/routes_name.dart';

class RightsIds {
  // static const leaveApply = "ESSMRID200700000002";
  // static const attendance = "ESSMRID200700000003";
  // static const paySlip = "ESSMRID200700000004";
  // static const leaveBalance = "ESSMRID200700000005";
  // static const leaveWithdraw = "ESSMRID200700000006";
  // static const leaveHistory = "ESSMRID200700000007";
  // static const leaveApproval = "ESSMRID200700000008";
  // static const leaveStatus = "ESSMRID200700000009";
  // static const leaveLedger = "ESSMRID200700000010";
  // static const accountBalance = "ESSMRID200700000011";
  // static const accountLedger = "ESSMRID200700000012";
  // static const teamPunch = "ESSMRID200700000013";
  // static const attendanceSummary = "ESSMRID200700000014";
  //Profile -----> 0000RTID1006A0000037


  static const leaveApply = "SOAURTIDPORTAL000297";
  static const attendance = "SPAURTID1410A0000116";
  static const paySlip = "SOAURTIDPORTAL000293";
  static const leaveBalance = "SOAURTIDPORTAL000294";
  static const leaveWithdraw = "SOAURTIDPORTAL000314";
 // static const leaveHistory = "SOAURTIDPORTAL000297"; ///leave history rights depend on leave apply
  static const leaveApproval = "SOAURTIDPORTAL000306";
  static const leaveStatus = "SOAURTIDPORTAL000312";
  static const leaveLedger = "SOAURTIDPORTAL000305";
  static const accountBalance = "SPAURTID1410A0000117";
  static const accountLedger = "RIID2207A0000002";
  static const teamPunch = "SOAURTIDPORTAL000304";
  static const attendanceSummary = "ESSMRID200700000014";

  static final Map<String, AppDashboardRoutes> routeMap = {
    RightsIds.leaveApply: AppDashboardRoutes(route: RoutesName.leaveApply, name: "Apply Leave"),
    RightsIds.leaveBalance:
        AppDashboardRoutes(route: RoutesName.leaveBalance, name: "Leave Balance"),
    RightsIds.leaveWithdraw:
        AppDashboardRoutes(route: RoutesName.leaveWithdrawal, name: "Leave Withdrawal"),
    // RightsIds.leaveHistory:
    //     AppDashboardRoutes(route: RoutesName.leaveHistory, name: "Leave History"),
    RightsIds.leaveApproval:
        AppDashboardRoutes(route: RoutesName.leaveApproval, name: "Leave Approval"),
    RightsIds.leaveStatus: AppDashboardRoutes(route: RoutesName.leaveStatus, name: "Leave Status"),
    RightsIds.leaveLedger: AppDashboardRoutes(route: RoutesName.leaveLedger, name: "Leave Ledger"),
    RightsIds.paySlip: AppDashboardRoutes(route: RoutesName.payslip, name: "Payslip"),
    RightsIds.attendance:
        AppDashboardRoutes(route: RoutesName.attendancePunches, name: "Attendance Punches"),
  //  RightsIds.attendanceSummary:
      //  AppDashboardRoutes(route: RoutesName.attendanceSummary, name: "Attendance Summary"),
    RightsIds.teamPunch:
        AppDashboardRoutes(route: RoutesName.teamAttendance, name: "Team Attendance"),
    RightsIds.accountBalance:
        AppDashboardRoutes(route: RoutesName.accountBalance, name: "Account Balance"),
    RightsIds.accountLedger:
        AppDashboardRoutes(route: RoutesName.accountLedger, name: "Account Ledger"),
  };
}
