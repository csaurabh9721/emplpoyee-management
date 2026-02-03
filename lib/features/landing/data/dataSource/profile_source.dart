import 'package:clientone_ess/core/network/apiClients/get_api_base.dart';

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
      final Map<String, dynamic> json = await GetApiBase.instance.getApi(
        url: "",
      );
      final ProfileInfoModel data = ProfileInfoModel.fromJson(json);
      return data;
    } catch (e) {
      throw AppException(e.toString());
    }
  }

  @override
  Future<AddressInfoModel> getAddressInfo() async {
    try {
      final Map<String, dynamic> json = await GetApiBase.instance.getApi(
        url: "",
      );
      final AddressInfoModel data = AddressInfoModel.fromJson(json);
      return data;
    } catch (e) {
      throw AppException(e.toString());
    }
  }
}
