import 'package:clientone_ess/shared/constants/local_stored_data.dart';

import '../../../core/exceptions/api_exceptions.dart';
import '../../../core/network/apiClients/post_api_base.dart';
import '../../../core/network/config/network_config.dart';
import '../models/leave_apply_models.dart';

class LeaveApplyService {
  Future<LeaveApplyResponse> applyLeave({
    required String leaveType,
    required DateTime startDate,
    required DateTime endDate,
    required String reason,
  }) async {
    try {
      final LeaveRequestModel leaveRequest = LeaveRequestModel(
        employeeId: LocalStoredData.employeeId,
        leaveType: leaveType,
        startDate: startDate,
        endDate: endDate,
        reason: reason,
      );
      final Map<String, dynamic> json =
          await PostApiBase.instance.post(url: NetworkConfig.leaveApply, body: leaveRequest.toJson());
      if (json['statusCode'] != 201 ) {
        throw AppException(json['message'] ?? "Failed to apply leave");
      }
      return LeaveApplyResponse.fromJson(json);
    } catch (e) {
      print(e.toString());
      throw AppException(e.toString());
    }
  }
}
