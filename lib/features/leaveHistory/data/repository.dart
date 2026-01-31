import 'package:clientone_ess/features/leaveHistory/data/leave_history_source.dart';
import 'package:clientone_ess/features/leaveHistory/domain/entity.dart';

import '../../../core/exceptions/api_exceptions.dart';
import '../domain/leave_history_repository.dart';
import 'model.dart';

class LeaveHistoryRepositoryImpl implements LeaveHistoryRepository {
  LeaveHistoryRepositoryImpl(this._remoteLeaveHistorySource);
  final LeaveHistorySource _remoteLeaveHistorySource;

  @override
  Future<List<LeaveHistoryEntity>> getLeaveHistoryEntity(
      String startDate, String endDate) async {
    final LeaveHistoryModel response =
        await _remoteLeaveHistorySource.getData(startDate, endDate);
    if (response.statusCode != "200" && response.statusCode != "204") {
      throw AppException(response.message);
    }
    if (response.data == null) {
      throw AppException("Failed to fetch Leave History");
    }
    return response.dtoToList();
  }
}
