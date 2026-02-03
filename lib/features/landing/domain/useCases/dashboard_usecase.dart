import '../entity/dashboard_response_entity.dart';
import '../repository/dashboard_repository.dart';

abstract class DashboardUseCase {
  Future<DashboardResponseEntity> call();
}

class DashboardUseCaseImpl implements DashboardUseCase {

  DashboardUseCaseImpl(this._repository);
  final DashboardRepository _repository;

  @override
  Future<DashboardResponseEntity> call()  {
    return  _repository.getDashBoardData();
  }
}
