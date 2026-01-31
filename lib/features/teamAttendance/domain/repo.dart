import 'entity/entity.dart';
import 'entity/send_entity.dart';

abstract class TeamAttendanceRepo {
  Future<List<TeamAttendanceEntity>> fetchTeamAttendance(TeamAttendanceRequest request);
}
