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
    final DashboardResponseModel data =
        await _remoteDashboardSource.getDashBoardData();
    if (data.statusCode != 200) {
      throw AppException(data.message);
    }
    return data.modelToEntity();
  }
}
