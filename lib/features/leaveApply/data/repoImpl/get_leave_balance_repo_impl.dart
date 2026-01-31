import '../../../../core/exceptions/api_exceptions.dart';
import '../../domain/entities/leave_balance_entity.dart';
import '../../domain/repo/get_leave_balance_repo.dart';
import '../dataSources/get_leave_balance_data_source.dart';
import '../models/leave_balance_model.dart';

class GetLeaveBalanceRepoImpl implements GetLeaveBalanceRepo {

  GetLeaveBalanceRepoImpl(this._source);
  final GetLeaveBalanceDataSource _source;

  @override
  Future<ApplyLeaveBalanceEntity> getLeaveBalance(String date) async {
    final ApplyLeaveBalanceResponseModel response = await _source.getLeaveBalance(date);
    final int statusCode = int.parse(response.statusCode);
    if (statusCode < 200 || statusCode >= 300) {
      throw AppException(response.message);
    }
    return response.dtoToEntity();
  }
}
