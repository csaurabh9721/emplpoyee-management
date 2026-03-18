import '../../../core/network/apiClients/post_api_base.dart';
import '../models/attendance_model.dart';

class AttendanceService {
  final PostApiBase _apiBase = PostApiBase.instance;

  Future<AttendanceData> getAttendanceData() async {
    // Mocking API call for now
    await Future.delayed(const Duration(seconds: 3));
    
    final today = AttendanceModel(
      date: 'Oct 24, 2023',
      checkIn: '09:00 AM',
      checkOut: '06:00 PM',
      status: 'Present',
      workingHours: '9h 00m',
    );

    final history = [
      AttendanceModel(date: 'Oct 23, 2023', checkIn: '09:15 AM', checkOut: '06:10 PM', status: 'Present', workingHours: '8h 55m'),
      AttendanceModel(date: 'Oct 22, 2023', checkIn: '09:05 AM', checkOut: '06:05 PM', status: 'Present', workingHours: '9h 00m'),
      AttendanceModel(date: 'Oct 21, 2023', checkIn: '-', checkOut: '-', status: 'Absent', workingHours: '0h 00m'),
      AttendanceModel(date: 'Oct 20, 2023', checkIn: '08:55 AM', checkOut: '05:55 PM', status: 'Present', workingHours: '9h 00m'),
    ];

    return AttendanceData(today: today, history: history);
  }
}
