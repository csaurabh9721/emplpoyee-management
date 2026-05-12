import 'package:clientone_ess/core/exceptions/api_exceptions.dart';
import 'package:clientone_ess/core/network/apiClients/put_api_base.dart';
import 'package:flutter/cupertino.dart';
import '../../../core/network/config/network_config.dart';
import '../models/change_password_model.dart';

class ChangePasswordService {
  final PutApiBase _apiClient = PutApiBase.instance;

  Future<ChangePasswordResponse> changePassword(ChangePasswordRequest request) async {
    try {
      final response = await _apiClient.putApi(
        url: NetworkConfig.changePassword,
        body: request.toJson(),
      );

      return ChangePasswordResponse.fromJson(response);
    } catch (e) {
      debugPrint(e.toString());
      throw AppException('$e');
    }
  }
}
