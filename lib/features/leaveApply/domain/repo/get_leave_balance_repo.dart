
import '../entities/leave_balance_entity.dart';

abstract class GetLeaveBalanceRepo {
  Future<ApplyLeaveBalanceEntity> getLeaveBalance(String date);
}
