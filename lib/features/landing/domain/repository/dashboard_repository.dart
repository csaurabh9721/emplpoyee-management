

import '../entity/dashboard_response_entity.dart';

abstract class DashboardRepository{
  Future<DashboardResponseEntity> getDashBoardData();
}