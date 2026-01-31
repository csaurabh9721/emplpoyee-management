import 'entity/entity.dart';
import 'entity/send_entity.dart';
import 'repo.dart';

abstract class GetTeamAttendanceUsecase {
  Future<List<TeamAttendanceEntity>> call(TeamAttendanceRequest request);
}

class GetTeamAttendanceUsecaseImpl implements GetTeamAttendanceUsecase {

  GetTeamAttendanceUsecaseImpl(this._repo);
  final TeamAttendanceRepo _repo;

  @override
  Future<List<TeamAttendanceEntity>> call(TeamAttendanceRequest request) {
    return _repo.fetchTeamAttendance(request);
  }
}
