import 'package:clientone_ess/core/network/apiClients/get_api_base.dart';
import 'package:clientone_ess/core/network/config/network_config.dart';

import '../models/attendance_model.dart';

class AttendanceService {
  final GetApiBase _apiBase = GetApiBase.instance;

  Future<AttendanceData> getAttendanceData() async {
    final Map<String, dynamic> response =
        await _apiBase.getApi(url: NetworkConfig.getAttendanceByEmployeeId);
    final List<AttendanceModel> attendanceList = List.from(response['body'])
        .map((e) => AttendanceModel.fromJson(e))
        .toList();

    return AttendanceData(
        today: attendanceList.last,
        history:
            attendanceList.reversed.toList().sublist(1, attendanceList.length));
  }
}
