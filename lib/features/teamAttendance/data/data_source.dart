import 'package:clientone_ess/core/network/apiClients/post_api_base.dart';
import 'package:clientone_ess/core/network/config/network_config.dart';
import 'package:clientone_ess/features/teamAttendance/data/payload.dart';

import '../../../../core/exceptions/api_exceptions.dart';
import 'model.dart';

abstract class TeamAttendanceSource {
  Future<TeamAttendanceResponse> getAttendance(TeamAttendancePayload payload);
}

class TeamAttendanceImpl implements TeamAttendanceSource {
  @override
  Future<TeamAttendanceResponse> getAttendance(
      TeamAttendancePayload payload) async {
    try {
      final Map<String, dynamic> json = await PostApiBase.instance.post(url: "", body: payload.toJson);
      return TeamAttendanceResponse.fromJson(json);
    } catch (e) {
      throw AppException(e.toString());
    }
  }
}
