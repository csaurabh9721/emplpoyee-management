import 'entity.dart';
import 'leave_history_repository.dart';

abstract class GetLeaveHistoryUseCase {
  Future<List<LeaveHistoryEntity>> call(String startDate, String endDate);
}

class GetLeaveHistoryUseCaseImpl implements GetLeaveHistoryUseCase {

  GetLeaveHistoryUseCaseImpl(this._repository);
  final LeaveHistoryRepository _repository;

  @override
  Future<List<LeaveHistoryEntity>> call(String startDate, String endDate) async {
      final List<LeaveHistoryEntity> apiData = await _repository.getLeaveHistoryEntity(startDate, endDate);
      return apiData;

  }
}
