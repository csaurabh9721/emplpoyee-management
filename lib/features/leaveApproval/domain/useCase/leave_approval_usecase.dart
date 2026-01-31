import 'package:clientone_ess/features/leaveApproval/domain/repo/leave_approval_repo.dart';

abstract class LeaveApprovalUsecase {
  Future<String> callApproveLeave(String empId, String leaveId, String? remark);

  Future<String> callRejectLeave(String empId, String leaveId, String? remark);
}

class LeaveApprovalUsecaseImpl implements LeaveApprovalUsecase {
  LeaveApprovalUsecaseImpl(this._repo);
  final LeaveApprovalRepo _repo;

  @override
  Future<String> callApproveLeave(
      String empId, String leaveId, String? remark) {
    return _repo.approveLeave(empId, leaveId, remark);
  }

  @override
  Future<String> callRejectLeave(String empId, String leaveId, String? remark) {
    return _repo.rejectLeave(empId, leaveId, remark);
  }
}
