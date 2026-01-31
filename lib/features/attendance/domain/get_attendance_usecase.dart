import 'package:clientone_ess/features/attendance/domain/repo.dart';

import 'attendance_entity.dart';

abstract class GetAttendanceUsecase {
  Future<AttendanceEntity> call(String startDate, String endDate);
}

class GetAttendanceUsecaseImpl extends GetAttendanceUsecase {
  GetAttendanceUsecaseImpl(this._repo);
  final GetAttendanceRepo _repo;

  @override
  Future<AttendanceEntity> call(String startDate, String endDate) async {
    return _repo.getAttendance(startDate, endDate);
  }
}
