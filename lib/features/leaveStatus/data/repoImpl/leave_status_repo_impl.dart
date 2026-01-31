import 'package:clientone_ess/features/leaveStatus/domain/entity/leave_status_entity.dart';

import '../../../../core/exceptions/api_exceptions.dart';
import '../../domain/repository/get_leave_status_repository.dart';
import '../dataSource/leave_status_source.dart';
import '../models/leave_status_model.dart';

class GetLeaveStatusRepositoryImpl implements GetLeaveStatusRepository {
  GetLeaveStatusRepositoryImpl(this._leaveStatusSource);
  final LeaveStatusSource _leaveStatusSource;

  @override
  Future<List<LeaveStatusEntity>> getLeaveStatus(
      {required String fromDate,
      required String toDate,
      required String leaveType,
      required String leaveStatus}) async {
    final LeaveStatusResponseModel response =
        await _leaveStatusSource.getLeaveCode(
            fromDate: fromDate,
            toDate: toDate,
            leaveType: leaveType,
            leaveStatus: leaveStatus);
    if (response.statusCode != "200") {
      throw AppException(response.message);
    }
    return response.toEntity();
  }

  @override
  Future<bool> leaveWithdraw(String leaveApplicationNo, String withdrawReason) {
    return _leaveStatusSource.withdrawLeave(leaveApplicationNo, withdrawReason);
  }
}
