import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/edit_profile_model.dart';
import '../services/edit_profile_service.dart';
import 'profile_controller.dart';

class EditProfileController extends GetxController {
  final EditProfileService _editProfileService = EditProfileService();

  // Form controllers
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController stateController = TextEditingController();
  final TextEditingController postalCodeController = TextEditingController();
  final TextEditingController countryController = TextEditingController();
  final TextEditingController pAddressController = TextEditingController();
  final TextEditingController pCityController = TextEditingController();
  final TextEditingController pStateController = TextEditingController();
  final TextEditingController pPostalCodeController = TextEditingController();
  final TextEditingController pCountryController = TextEditingController();
  final TextEditingController emergencyContactNameController = TextEditingController();
  final TextEditingController emergencyContactPhoneController = TextEditingController();
  final TextEditingController emergencyContactRelationController = TextEditingController();

  // Dropdown values
  final List<String> genders = ['MALE', 'FEMALE', 'OTHER'];
  final List<String> maritalStatuses = ['MARRIED', 'SINGLE'];
  final List<String> bloodGroups = [
    'A_POSITIVE',
    'A_NEGATIVE',
    'B_POSITIVE',
    'B_NEGATIVE',
    'AB_POSITIVE',
    'AB_NEGATIVE',
    'O_POSITIVE',
    'O_NEGATIVE'
  ];

  RxString selectedGender = ''.obs;
  RxString selectedMaritalStatus = ''.obs;
  RxString selectedBloodGroup = ''.obs;

  final ProfileController _profileController = Get.find();

  // State management
  RxBool isLoading = false.obs;
  RxBool isSameAsCurrent = false.obs;

  @override
  void onInit() {
    _populateFormFields();
    super.onInit();
  }

  void _populateFormFields() {
    nameController.text = _profileController.data.fullName;
    emailController.text = _profileController.data.personalDetails.personalEmail;
    phoneController.text = _profileController.data.personalDetails.alternateMobileNumber;
    addressController.text = _profileController.data.employeeAddress.address;
    cityController.text = _profileController.data.employeeAddress.city;
    stateController.text = _profileController.data.employeeAddress.state;
    postalCodeController.text = _profileController.data.employeeAddress.postalCode;
    countryController.text = _profileController.data.employeeAddress.country;
    pAddressController.text = _profileController.data.employeeAddress.permanentAddress;
    pCityController.text = _profileController.data.employeeAddress.permanentCity;
    pStateController.text = _profileController.data.employeeAddress.permanentState;
    pPostalCodeController.text = _profileController.data.employeeAddress.permanentPostalCode;
    pCountryController.text = _profileController.data.employeeAddress.permanentCountry;

    emergencyContactNameController.text = _profileController.emergencyContact.name;
    emergencyContactPhoneController.text = _profileController.emergencyContact.phone;
    emergencyContactRelationController.text = _profileController.emergencyContact.relation;

    selectedGender.value = _profileController.data.personalDetails.gender;
    selectedMaritalStatus.value = _profileController.data.personalDetails.maritalStatus;
    selectedBloodGroup.value = _profileController.data.personalDetails.bloodGroup;

    // Check if current and permanent addresses are the same to initialize the checkbox
    if (addressController.text == pAddressController.text &&
        cityController.text == pCityController.text &&
        stateController.text == pStateController.text &&
        postalCodeController.text == pPostalCodeController.text &&
        countryController.text == pCountryController.text &&
        addressController.text.isNotEmpty) {
      isSameAsCurrent.value = true;
    }
  }

  void toggleSameAsCurrent(bool? value) {
    isSameAsCurrent.value = value ?? false;
    if (isSameAsCurrent.value) {
      pAddressController.text = addressController.text;
      pCityController.text = cityController.text;
      pStateController.text = stateController.text;
      pPostalCodeController.text = postalCodeController.text;
      pCountryController.text = countryController.text;
    }
  }

  Future<void> updateProfile() async {
    try {
      isLoading.value = true;

      final EditProfileRequest request = EditProfileRequest(
        employeeId: _profileController.data.id,
        fullName: nameController.text.trim(),
        personalEmail: emailController.text.trim(),
        alternateMobileNumber: phoneController.text.trim(),
        gender: selectedGender.value,
        maritalStatus: selectedMaritalStatus.value,
        bloodGroup: selectedBloodGroup.value,
        address: addressController.text.trim(),
        city: cityController.text.trim(),
        state: stateController.text.trim(),
        postalCode: postalCodeController.text.trim(),
        country: countryController.text.trim(),
        permanentAddress: pAddressController.text.trim(),
        permanentCity: pCityController.text.trim(),
        permanentState: pStateController.text.trim(),
        permanentPostalCode: pPostalCodeController.text.trim(),
        permanentCountry: pCountryController.text.trim(),
        emergencyName: emergencyContactNameController.text.trim(),
        emergencyPhone: emergencyContactPhoneController.text.trim(),
        emergencyRelation: emergencyContactRelationController.text.trim(),
      );

      final response = await _editProfileService.updateProfile(request);
      isLoading.value = false;
      Get.back();
      Get.snackbar(
        'Success',
        response.message,
        backgroundColor: Colors.green,
        colorText: Colors.white,
        duration: const Duration(seconds: 2),
      );
      _profileController.refreshProfile();
    } catch (e) {
      isLoading.value = false;
      Get.snackbar(
        'Error',
        e.toString().replaceAll('Exception: ', ''),
        backgroundColor: Colors.red,
        colorText: Colors.white,
        duration: const Duration(seconds: 2),
      );
    }
  }

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    addressController.dispose();
    cityController.dispose();
    stateController.dispose();
    postalCodeController.dispose();
    countryController.dispose();
    pAddressController.dispose();
    pCityController.dispose();
    pStateController.dispose();
    pPostalCodeController.dispose();
    pCountryController.dispose();
    emergencyContactNameController.dispose();
    emergencyContactPhoneController.dispose();
    emergencyContactRelationController.dispose();
    super.onClose();
  }
}
