import 'package:clientone_ess/features/teamAttendance/data/payload.dart';

import '../domain/entity/entity.dart';
import '../domain/entity/send_entity.dart';
import '../domain/repo.dart';
import 'data_source.dart';
import 'model.dart';

class TeamAttendanceRepoImpl implements TeamAttendanceRepo {
  TeamAttendanceRepoImpl(this._source);
  final TeamAttendanceSource _source;

  @override
  Future<List<TeamAttendanceEntity>> fetchTeamAttendance(
      TeamAttendanceRequest request) async {
    final TeamAttendanceResponse response =
        await _source.getAttendance(TeamAttendancePayload(request));
    if (response.statusCode != 200) {
      throw Exception(response.message);
    }
    if (response.entity == null) {
      throw Exception(response.message);
    }
    return response.toEntity;
  }
}
