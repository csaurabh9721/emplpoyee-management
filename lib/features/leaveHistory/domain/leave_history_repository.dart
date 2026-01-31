
import 'entity.dart';

abstract class LeaveHistoryRepository{
  Future<List<LeaveHistoryEntity>> getLeaveHistoryEntity(String startDate, String endDate);
}