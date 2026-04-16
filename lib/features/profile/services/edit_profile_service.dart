import 'dart:convert';
import 'dart:developer';
import 'package:clientone_ess/core/routes/routes_name.dart';
import 'package:clientone_ess/core/service/sessionManagement/sessions.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../../core/exceptions/api_exceptions.dart';
import '../../../core/network/apiClients/put_api_base.dart';
import '../../../core/network/config/network_config.dart';
import '../models/edit_profile_model.dart';
import '../models/profile_model.dart';

class EditProfileService {
  Future<ProfileModel> updateProfile(EditProfileRequest request) async {
    try {
      final Map<String, dynamic> response =
          await PutApiBase.instance.putApi(url: NetworkConfig.updateProfile, body: request.toJson());
      return ProfileModel.fromJson(response);
    } catch (e) {
      log(e.toString());
      throw AppException(e.toString());
    }
  }
}
