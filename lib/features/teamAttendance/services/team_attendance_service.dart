import '../../../core/exceptions/api_exceptions.dart';
import '../../../core/network/apiClients/get_api_base.dart';
import '../../../core/network/config/network_config.dart';
import '../../../core/utils/date_formatter.dart';
import '../models/team_attendance_model.dart';

class TeamAttendanceService {

  final GetApiBase _apiBase = GetApiBase.instance;

  Future<List<TeamAttendanceModel>> getTeamAttendanceData(DateTime startDate, DateTime endDate) async {
    try {
      final String sDate = startDate.yyyyMMDDDash();
      final String eDate = endDate.yyyyMMDDDash();
      final String queryParam = "?startDate=$sDate&endDate=$eDate";
      final Map<String, dynamic> response = await _apiBase.getApi(
          url: NetworkConfig.getAttendanceForMangerByDateRange + queryParam);
      if (response['statusCode'] != 200 || response['body'] == null) {
        throw Exception(
            response['message'] ?? "Failed to fetch attendance data.");
      }
      return List.from(response['body'])
          .map((e) => TeamAttendanceModel.fromJson(e))
          .toList();
    } catch (e) {
      throw AppException("Failed to fetch attendance data.");
    }
  }
}
