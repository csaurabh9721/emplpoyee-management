import 'package:clientone_ess/core/routes/routes_name.dart';
import 'package:clientone_ess/core/service/sessionManagement/sessions.dart';
import 'package:get/get.dart';
import '../../../core/utils/base_api_response.dart';
import '../models/profile_model.dart';
import '../services/profile_service.dart';

class ProfileController extends GetxController {
  final ProfileService _profileService = ProfileService();

  BaseApiResponse<ProfileModelBody> profileData = BaseApiResponse.loading();

  ProfileModelBody get data => profileData.data!;

  PersonalDetails get personalInfo => profileData.data!.personalDetails;
  EmergencyContact get emergencyContact => profileData.data!.emergencyContact;
  EmployeeBankDetails get bankDetails => profileData.data!.employeeBankDetails;

  String get fullAddress =>
      "${profileData.data!.employeeAddress.address}, ${profileData.data!.employeeAddress.city}, ${profileData.data!.employeeAddress.state}, ${profileData.data!.employeeAddress.country}";

  @override
  void onInit() {
    super.onInit();
    _loadProfileData();
  }

  Future<void> _loadProfileData() async {
    try {
      profileData = BaseApiResponse.loading();
      update();
      final ProfileModelBody data = await _profileService.getProfileData();
      profileData = BaseApiResponse.success(data: data);
      update();
    } catch (e) {
      profileData = BaseApiResponse.error(e.toString());
      update();
    }
  }

  Future<void> refreshProfile() async {
    _loadProfileData();
  }

  void logout() {
    Sessions.erase();
    Get.offAllNamed(RoutesName.login);
  }
}
