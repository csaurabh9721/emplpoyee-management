import '../../domain/repo/leave_approval_repo.dart';
import '../dataSource/leave_approval_source.dart';

class LeaveApprovalRepoImpl extends LeaveApprovalRepo {

  LeaveApprovalRepoImpl(this._source);
  final LeaveApprovalSource _source;

  @override
  Future<String> approveLeave(String empId, String leaveId, String? remark) {
    return _source.approveLeave(empId, leaveId, remark);
  }

  @override
  Future<String> rejectLeave(String empId, String leaveId, String? remark) {
    return _source.rejectLeave(empId, leaveId, remark);
  }
}
