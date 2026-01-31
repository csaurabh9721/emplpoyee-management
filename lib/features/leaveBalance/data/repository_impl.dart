import 'package:clientone_ess/core/exceptions/api_exceptions.dart';
import 'package:clientone_ess/features/leaveBalance/data/leave_balance_source.dart';
import 'package:clientone_ess/features/leaveBalance/domain/entity.dart';

import '../domain/repository.dart';
import 'model.dart';

class LeaveBalanceRepositoryImpl extends LeaveBalanceRepository {
  LeaveBalanceRepositoryImpl(this._source);
  final LeaveBalanceSource _source;

  @override
  Future<List<LeaveBalanceEntity>> getLeaveBalance(String date) async {
    final LeaveBalanceModel response = await _source.getData(date);
    if (response.statusCode != 200) {
      throw AppException(response.message);
    }
    if (response.leaveBalanceDataModel == null) {
      throw AppException("Something went wrong");
    }
    return response.toEntity();
  }
}
