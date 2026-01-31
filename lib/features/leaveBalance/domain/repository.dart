

import 'entity.dart';

abstract class LeaveBalanceRepository{
  Future<List<LeaveBalanceEntity>> getLeaveBalance(String date);
}