import '../../../core/exceptions/api_exceptions.dart';
import '../domain/attendance_entity.dart';
import '../domain/repo.dart';
import 'attendance_source.dart';
import 'model.dart';

class GetAttendanceRepoImpl implements GetAttendanceRepo {

  GetAttendanceRepoImpl(this._source);
  final AttendanceSource _source;

  @override
  Future<AttendanceEntity> getAttendance(String startDate, String endDate) async {
    final GetSelfAttendanceResponse response = await _source.getData(startDate, endDate);
    if (response.statusCode != 200) {
      throw AppException(response.message);
    }
    if (response.entity == null) {
      throw AppException(response.message);
    }
    return response.toEntity();
  }
}
