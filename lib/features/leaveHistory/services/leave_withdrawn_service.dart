import 'package:clientone_ess/core/network/apiClients/put_api_base.dart';
import 'package:flutter/cupertino.dart';
import '../../../core/exceptions/api_exceptions.dart';
import '../../../core/network/apiClients/get_api_base.dart';
import '../../../core/network/config/network_config.dart';
import '../../leaveManagementPage/models/leave_models.dart';

class LeaveWithdrawnService {

  Future<String> withdrawLeave(int id) async {
    try {
      final Map<String, dynamic> json = await PutApiBase.instance.putApi(url: "${NetworkConfig.leaveWithdrawn}/$id");
      if (json["statusCode"] != 200 && json["body"] == null) {
        throw AppException(json["message"] ?? "Something went wrong");
      }
      return json["message"] ?? "Leave request withdrawn successfully";
    } catch (e) {
      debugPrint(e.toString());
      throw AppException('$e');
    }
  }
}
