import '../entity/leave_status_entity.dart';
import '../repository/get_leave_status_repository.dart';

abstract class GetLeaveStatusUsecase {
  Future<List<LeaveStatusEntity>> callLeaveStatus(
      {required String fromDate,
      required String toDate,
      required String leaveType,
      required String leaveStatus});

  Future<bool> callLeaveWithdraw(String leaveApplicationNo,String withdrawReason);
}

class GetLeaveStatusUsecaseImpl implements GetLeaveStatusUsecase {

  GetLeaveStatusUsecaseImpl(this._repository);
  final GetLeaveStatusRepository _repository;

  @override
  Future<List<LeaveStatusEntity>> callLeaveStatus(
      {required String fromDate,
      required String toDate,
      required String leaveType,
      required String leaveStatus}) async {
    return await _repository.getLeaveStatus(
        fromDate: fromDate, toDate: toDate, leaveType: leaveType, leaveStatus: leaveStatus);
  }

  @override
  Future<bool> callLeaveWithdraw(String leaveApplicationNo,String withdrawReason) async {
    return await _repository.leaveWithdraw(leaveApplicationNo, withdrawReason );
  }
}
