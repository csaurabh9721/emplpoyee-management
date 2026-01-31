
import '../entity/leave_code_entity.dart';

abstract class GetLeaveCodeRepository {
  Future<List<LeaveCode>> getLeaveCodes();
}