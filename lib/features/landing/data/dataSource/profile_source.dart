import 'package:clientone_ess/core/network/apiClients/post_api_base.dart';
import 'package:clientone_ess/core/network/config/network_config.dart';
import 'package:clientone_ess/core/service/sessionManagement/sessions.dart';

import '../../../../core/exceptions/api_exceptions.dart';
import '../models/address_info_model.dart';
import '../models/profile_model.dart';

abstract class ProfileSource {
  Future<ProfileInfoModel> getProfileInfo();

  Future<AddressInfoModel> getAddressInfo();
}

class ProfileSourceImpl implements ProfileSource {
  @override
  Future<ProfileInfoModel> getProfileInfo() async {
    try {
      final Map<String, String> body = {"employeeid": Sessions.getEmployeeId()};
      final Map<String, dynamic> json = await PostApiBase.instance
          .post(url: "", body: body);
      final ProfileInfoModel data = ProfileInfoModel.fromJson(json);
      return data;
    } catch (e) {
      throw AppException(e.toString());
    }
  }

  @override
  Future<AddressInfoModel> getAddressInfo() async {
    try {
      final Map<String, String> body = {"employeeid": Sessions.getEmployeeId()};
      final Map<String, dynamic> json = await PostApiBase.instance
          .post(url: "", body: body);
      final AddressInfoModel data = AddressInfoModel.fromJson(json);
      return data;
    } catch (e) {
      throw AppException(e.toString());
    }
  }
}
