import 'package:clientone_ess/features/leaveApply/domain/entities/continuous_paid_leave.dart';

import '../../domain/repo/continuous_paid_leave_repo.dart';
import '../dataSources/continuous_paid_leave_source.dart';
import '../models/check_continuous_paid_leave_payload.dart';

class ContinuousPaidLeaveRepoImpl implements ContinuousPaidLeaveRepo {
  ContinuousPaidLeaveRepoImpl(this._source);
  final ContinuousPaidLeaveSource _source;

  @override
  Future<Map<int, String>> checkContinuousPaidLeave(
      ContinuousPaidLeaveEntity postData) {
    return _source.checkContinuousPaidLeave(
        CheckContinuousPaidLeavePayload.copyWith(postData));
  }
}
