import 'package:clientone_ess/features/landing/domain/entity/dashboard_response_entity.dart';

import '../../../../core/exceptions/api_exceptions.dart';
import '../../domain/repository/dashboard_repository.dart';
import '../dataSource/dashboard_source.dart';
import '../models/dashboard_response_model.dart';

class DashboardRepositoryImpl implements DashboardRepository {
  DashboardRepositoryImpl(this._remoteDashboardSource);

  final DashboardSource _remoteDashboardSource;

  @override
  Future<DashboardResponseEntity> getDashBoardData() async {
    final DashboardResponseModel data = await _remoteDashboardSource.getDashBoardData();
    if (data.statusCode != 200) {
      throw AppException(data.message);
    }
    if (data.body == null) {
      throw AppException(data.message);
    }
    return _modelToEntity(data.body!);
  }

  DashboardResponseEntity _modelToEntity(ResponseBody body) {
    try {
      final PunchInPunchOutEntity punchTime =
          PunchInPunchOutEntity(punchInTime: body.punchTime!.punchInTime, punchOutTime: body.punchTime!.punchOutTime);

      final List<PunchInPunchOutEntity> lastPunches = body.lastPunches
          .map((e) => PunchInPunchOutEntity(punchInTime: e.punchInTime, punchOutTime: e.punchOutTime))
          .toList();

      return DashboardResponseEntity(punchTime: punchTime, lastPunches: lastPunches);
    } catch (e) {
      throw AppException(e.toString());
    }
  }
}
