import '../entity/leave_status_entity.dart';

abstract class GetLeaveStatusRepository {
  Future<List<LeaveStatusEntity>> getLeaveStatus(
      {required String fromDate,
      required String toDate,
      required String leaveType,
      required String leaveStatus});

  Future<bool> leaveWithdraw(String leaveApplicationNo,String withdrawReason);
}
