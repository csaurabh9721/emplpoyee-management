import '../entities/leave_balance_entity.dart';
import '../repo/get_leave_balance_repo.dart';

abstract class GetLeaveBalanceUsecase {
  Future<ApplyLeaveBalanceEntity> getLeaveBalance(String date);
}

class GetLeaveBalanceUsecaseImpl implements GetLeaveBalanceUsecase {

  GetLeaveBalanceUsecaseImpl(this._repo);
  final GetLeaveBalanceRepo _repo;

  @override
  Future<ApplyLeaveBalanceEntity> getLeaveBalance(String date) async {
    return await _repo.getLeaveBalance(date);
  }
}
