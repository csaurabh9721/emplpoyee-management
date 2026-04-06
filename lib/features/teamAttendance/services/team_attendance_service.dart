import '../models/team_attendance_model.dart';

class TeamAttendanceService {
  Future<List<TeamAttendanceModel>> getTeamAttendance(DateTime date, String status) async {
    await Future.delayed(const Duration(milliseconds: 500));
    
    // Mock data
    final allEmployees = [
      TeamAttendanceModel(
        employeeId: 'EMP001',
        employeeName: 'John Doe',
        designation: 'Software Engineer',
        checkIn: '09:05 AM',
        checkOut: '06:10 PM',
        status: 'Present',
        avatar: 'https://i.pravatar.cc/150?img=1',
      ),
      TeamAttendanceModel(
        employeeId: 'EMP002',
        employeeName: 'Jane Smith',
        designation: 'UI Designer',
        checkIn: '--:--',
        checkOut: '--:--',
        status: 'Absent',
        avatar: 'https://i.pravatar.cc/150?img=5',
      ),
      TeamAttendanceModel(
        employeeId: 'EMP003',
        employeeName: 'Mike Ross',
        designation: 'Project Manager',
        checkIn: '09:15 AM',
        checkOut: '03:00 PM',
        status: 'Half Day',
        avatar: 'https://i.pravatar.cc/150?img=8',
      ),
      TeamAttendanceModel(
        employeeId: 'EMP004',
        employeeName: 'Sarah Connor',
        designation: 'QA Lead',
        checkIn: '08:55 AM',
        checkOut: '06:05 PM',
        status: 'Present',
        avatar: 'https://i.pravatar.cc/150?img=9',
      ),
    ];

    if (status == 'All') {
      return allEmployees;
    } else {
      return allEmployees.where((e) => e.status == status).toList();
    }
  }
}
