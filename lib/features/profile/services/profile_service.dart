import 'package:clientone_ess/core/network/config/network_config.dart';

import '../../../core/network/apiClients/get_api_base.dart';
import '../models/profile_model.dart';

class ProfileService {
  final GetApiBase _apiClient = GetApiBase.instance;

  Future<ProfileModelBody> getProfileData() async {
    try {
      final Map<String,dynamic> response = await _apiClient.getApi(url: NetworkConfig.getEmployeeProfile);
      return ProfileModel.fromJson(response).body;
    } catch (e) {
      throw Exception('Failed to load profile data: $e');
    }
  }
}
