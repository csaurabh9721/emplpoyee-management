import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/utils/base_api_response.dart';
import '../models/edit_profile_model.dart';
import '../models/profile_model.dart';
import '../services/edit_profile_service.dart';
import '../services/profile_service.dart';

class EditProfileController extends GetxController {
  final EditProfileService _editProfileService = EditProfileService();
  final ProfileService _profileService = ProfileService();

  // Form controllers
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController stateController = TextEditingController();
  final TextEditingController postalCodeController = TextEditingController();
  final TextEditingController countryController = TextEditingController();
  final TextEditingController emergencyContactNameController = TextEditingController();
  final TextEditingController emergencyContactPhoneController = TextEditingController();
  final TextEditingController emergencyContactRelationController = TextEditingController();

  // State management
  BaseApiResponse<EditProfileResponse> updateResponse = BaseApiResponse.initial();
  BaseApiResponse<ProfileModelBody> profileData = BaseApiResponse.loading();

  @override
  void onInit() {
    super.onInit();
    loadProfileData();
  }

  Future<void> loadProfileData() async {
    try {
      profileData = BaseApiResponse.loading();
      update();
      final ProfileModelBody data = await _profileService.getProfileData();
      profileData = BaseApiResponse.success(data: data);
      _populateFormFields(data);
      update();
    } catch (e) {
      profileData = BaseApiResponse.error(e.toString());
      update();
    }
  }

  void _populateFormFields(ProfileModelBody profile) {
    // firstNameController.text = profile.fullName;
    // lastNameController.text = profile.fullName;
    // emailController.text = profile.personalDetails.aadharNumber;
    // phoneController.text = profile.personalDetails.p;
    // addressController.text = profile.address;
    // cityController.text = profile.city;
    // stateController.text = profile.state;
    // postalCodeController.text = profile.postalCode;
    // countryController.text = profile.country;
    // emergencyContactNameController.text = profile.emergencyContactName;
    // emergencyContactPhoneController.text = profile.emergencyContactPhone;
    // emergencyContactRelationController.text = profile.emergencyContactRelation;
  }

  Future<void> updateProfile() async {
    try {
      updateResponse = BaseApiResponse.loading();
      update();

      final request = EditProfileRequest(
        firstName: firstNameController.text.trim(),
        lastName: lastNameController.text.trim(),
        email: emailController.text.trim(),
        phone: phoneController.text.trim(),
        address: addressController.text.trim(),
        city: cityController.text.trim(),
        state: stateController.text.trim(),
        postalCode: postalCodeController.text.trim(),
        country: countryController.text.trim(),
        emergencyContactName: emergencyContactNameController.text.trim(),
        emergencyContactPhone: emergencyContactPhoneController.text.trim(),
        emergencyContactRelation: emergencyContactRelationController.text.trim(),
      );

      final response = await _editProfileService.updateProfile(request);
      updateResponse = BaseApiResponse.success(data: response);
      update();

      if (response.success) {
        Get.snackbar(
          'Success',
          response.message,
          backgroundColor: Colors.green,
          colorText: Colors.white,
          duration: const Duration(seconds: 2),
        );
        // Navigate back to profile screen after successful update
        Future.delayed(const Duration(seconds: 2), () {
          Get.back();
        });
      }
    } catch (e) {
      updateResponse = BaseApiResponse.error(e.toString());
      update();
      Get.snackbar(
        'Error',
        'Failed to update profile',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        duration: const Duration(seconds: 2),
      );
    }
  }

  bool validateForm() {
    if (firstNameController.text.trim().isEmpty ||
        lastNameController.text.trim().isEmpty ||
        emailController.text.trim().isEmpty ||
        phoneController.text.trim().isEmpty) {
      Get.snackbar(
        'Validation Error',
        'Please fill in all required fields',
        backgroundColor: Colors.orange,
        colorText: Colors.white,
        duration: const Duration(seconds: 2),
      );
      return false;
    }

    // Basic email validation
    if (!GetUtils.isEmail(emailController.text.trim())) {
      Get.snackbar(
        'Validation Error',
        'Please enter a valid email address',
        backgroundColor: Colors.orange,
        colorText: Colors.white,
        duration: const Duration(seconds: 2),
      );
      return false;
    }

    return true;
  }

  @override
  void onClose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    addressController.dispose();
    cityController.dispose();
    stateController.dispose();
    postalCodeController.dispose();
    countryController.dispose();
    emergencyContactNameController.dispose();
    emergencyContactPhoneController.dispose();
    emergencyContactRelationController.dispose();
    super.onClose();
  }
}
