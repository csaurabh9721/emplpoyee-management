import '../entity/leave_code_entity.dart';
import '../repository/get_leave_code_repository.dart';

abstract class GetLeaveCodeUsecase {
  Future<List<LeaveCode>> call();
}

class GetLeaveCodeUsecaseImpl implements GetLeaveCodeUsecase {

  GetLeaveCodeUsecaseImpl(this._repository);
  final GetLeaveCodeRepository _repository;

  @override
  Future<List<LeaveCode>> call() async {
    return await _repository.getLeaveCodes();
  }
}
