import 'package:clientone_ess/core/exceptions/api_exceptions.dart';
import 'package:clientone_ess/core/network/apiClients/get_api_base.dart';
import 'package:clientone_ess/core/network/config/network_config.dart';
import 'package:clientone_ess/core/utils/date_formatter.dart';

import '../models/attendance_model.dart';

class AttendanceService {
  final GetApiBase _apiBase = GetApiBase.instance;

  Future<List<AttendanceModel>> getAttendanceData(
      DateTime startDate, DateTime endDate) async {
    try {
      final String sDate = startDate.yyyyMMDDDash();
      final String eDate = endDate.yyyyMMDDDash();
      final String queryParam = "?startDate=$sDate&endDate=$eDate";
      final Map<String, dynamic> response = await _apiBase.getApi(
          url: NetworkConfig.getAttendanceByDateRange + queryParam);
      if (response['statusCode'] != 200 || response['body'] == null) {
        throw Exception(
            response['message'] ?? "Failed to fetch attendance data.");
      }
      return List.from(response['body'])
          .map((e) => AttendanceModel.fromJson(e))
          .toList();
    } catch (e) {
      throw AppException("Failed to fetch attendance data.");
    }
  }
}
