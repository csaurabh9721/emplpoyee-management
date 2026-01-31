import 'package:clientone_ess/features/leaveBalance/domain/repository.dart';

import 'entity.dart';

abstract class GetLeaveBalanceLeaveUsecase {
  Future<List<LeaveBalanceEntity>> call(String date);
}

class GetLeaveBalanceLeaveUsecaseImpl implements GetLeaveBalanceLeaveUsecase {
  GetLeaveBalanceLeaveUsecaseImpl(this._repository);
  final LeaveBalanceRepository _repository;

  @override
  Future<List<LeaveBalanceEntity>> call(String date) async {
    return await _repository.getLeaveBalance(date);
  }
}
