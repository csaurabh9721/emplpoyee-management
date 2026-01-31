import '../entities/continuous_paid_leave.dart';

abstract class ContinuousPaidLeaveRepo {
  Future<Map<int, String>> checkContinuousPaidLeave(ContinuousPaidLeaveEntity payload);
}
