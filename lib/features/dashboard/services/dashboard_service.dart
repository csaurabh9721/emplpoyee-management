import '../../../core/network/apiClients/get_api_base.dart';
import '../models/dashboard_models.dart';

class DashboardService {

  final GetApiBase _apiClient = GetApiBase.instance;

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
            title: "Apply Management",
            icon: "leave",
            route: "/leave_apply",
          ),
          QuickActionModel(
            id: "2",
            title: "View Payslip",
            icon: "payslip",
            route: "/payslip",
          ),
          QuickActionModel(
            id: "3",
            title: "Profile",
            icon: "profile",
            route: "/profile",
          ),
        ],
      );
    } catch (e) {
      throw Exception('Failed to load dashboard data: $e');
    }
  }
}
