import 'attendance_entity.dart';

abstract class GetAttendanceRepo {
  Future<AttendanceEntity> getAttendance(String startDate, String endDate);
}
