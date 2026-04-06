//import '../../../core/network/apiClients/get_api_base.dart';
import '../../../core/routes/routes_name.dart';
import '../models/dashboard_models.dart';

class DashboardService {

  //final GetApiBase _apiClient = GetApiBase.instance;

  Future<DashboardDataModel> getDashboardData() async {
    await Future.delayed(const Duration(seconds: 3));
    try {
      // Return dummy data for now
      return DashboardDataModel(
        employeeName: "Alex Johnson",
        employeeId: "EMP001",
        todayAttendance: TodayAttendance(
          date: "Monday, Oct 23",
          time: "09:00 AM - 05:00 PM",
          role: "Senior Software Engineer",
        ),
        announcements: [
          AnnouncementModel(
            id: "1",
            title: "Annual Town Hall Meeting",
            description: "Join us this Friday for the annual town hall meeting...",
            date: "Oct 20, 2024",
            type: "COMPANY UPDATE",
          ),
          AnnouncementModel(
            id: "2",
            title: "New Health Insurance Options",
            description: "We have updated our health insurance provider list...",
            date: "Oct 18, 2024",
            type: "BENEFITS",
          ),
        ],
        quickActions: [
          QuickActionModel(
            id: "1",
            title: "Attendance",
            icon: "attendance",
            route: RoutesName.attendance,
          ),
          QuickActionModel(
            id: "2",
            title: "Balance",
            icon: "balance",
            route: RoutesName.accountBalance,
          ),
          QuickActionModel(
            id: "3",
            title: "Leave Management",
            icon: "leave",
            route: RoutesName.leaveManagementPage,
          ),
          QuickActionModel(
            id: "4",
            title: "Leave Approval",
            icon: "approval",
            route: RoutesName.leaveApproval,
          ),
          QuickActionModel(
            id: "5",
            title: "View Payslip",
            icon: "payslip",
            route: RoutesName.payslipHistory,
          ),
          QuickActionModel(
            id: "6",
            title: "Profile",
            icon: "profile",
            route: RoutesName.profile,
          ),
        ],
      );
    } catch (e) {
      throw Exception('Failed to load dashboard data: $e');
    }
  }
}
