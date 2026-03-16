import '../../../core/network/apiClients/get_api_base.dart';
import '../models/edit_profile_model.dart';

class EditProfileService {
  final GetApiBase _apiClient = GetApiBase.instance;

  Future<EditProfileResponse> updateProfile(EditProfileRequest request) async {
    await Future.delayed(const Duration(seconds: 2));
    try {
      // Simulate API call with dummy success response
      return EditProfileResponse(
        success: true,
        message: 'Profile updated successfully',
        updatedProfile: {
          'firstName': request.firstName,
          'lastName': request.lastName,
          'email': request.email,
          'phone': request.phone,
          'address': request.address,
          'city': request.city,
          'state': request.state,
          'postalCode': request.postalCode,
          'country': request.country,
          'emergencyContactName': request.emergencyContactName,
          'emergencyContactPhone': request.emergencyContactPhone,
          'emergencyContactRelation': request.emergencyContactRelation,
        },
      );
    } catch (e) {
      throw Exception('Failed to update profile: $e');
    }
  }
}
