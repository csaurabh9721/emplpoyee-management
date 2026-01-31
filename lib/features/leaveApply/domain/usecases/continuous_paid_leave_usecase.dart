

import '../entities/continuous_paid_leave.dart';
import '../repo/continuous_paid_leave_repo.dart';

abstract class ContinuousPaidLeaveUsecase {

  Future<Map<int,String>> continuousPaidLeave(ContinuousPaidLeaveEntity postData);
}

class ContinuousPaidLeaveUsecaseImpl implements ContinuousPaidLeaveUsecase {
  ContinuousPaidLeaveUsecaseImpl(this._repo);
  final ContinuousPaidLeaveRepo _repo;


  @override
  Future<Map<int,String>> continuousPaidLeave(ContinuousPaidLeaveEntity postData) {
    return _repo.checkContinuousPaidLeave(postData);
  }
}
