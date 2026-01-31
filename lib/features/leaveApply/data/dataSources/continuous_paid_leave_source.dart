import 'package:clientone_ess/core/network/apiClients/post_api_base.dart';
import 'package:clientone_ess/core/network/config/network_config.dart';

import '../models/check_continuous_paid_leave_payload.dart';

abstract class ContinuousPaidLeaveSource {
  Future<Map<int, String>> checkContinuousPaidLeave(
      CheckContinuousPaidLeavePayload payload);
}

class ContinuousPaidLeaveSourceImpl implements ContinuousPaidLeaveSource {
  @override
  Future<Map<int, String>> checkContinuousPaidLeave(
      CheckContinuousPaidLeavePayload payload) async {
    try {
      final Map<String, dynamic> json = await PostApiBase.instance.post(
          url: NetworkConfig.checkContinuousPaidLeave, body: payload.toJson());
      return {json['statuscode']: json['message']};
    } catch (e) {
      return {400: e.toString()};
    }
  }
}
