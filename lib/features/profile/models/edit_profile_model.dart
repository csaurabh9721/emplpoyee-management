class EditProfileRequest {
  final String firstName;
  final String lastName;
  final String email;
  final String phone;
  final String address;
  final String city;
  final String state;
  final String postalCode;
  final String country;
  final String emergencyContactName;
  final String emergencyContactPhone;
  final String emergencyContactRelation;

  EditProfileRequest({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
    required this.address,
    required this.city,
    required this.state,
    required this.postalCode,
    required this.country,
    required this.emergencyContactName,
    required this.emergencyContactPhone,
    required this.emergencyContactRelation,
  });

  Map<String, dynamic> toJson() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'phone': phone,
      'address': address,
      'city': city,
      'state': state,
      'postalCode': postalCode,
      'country': country,
      'emergencyContactName': emergencyContactName,
      'emergencyContactPhone': emergencyContactPhone,
      'emergencyContactRelation': emergencyContactRelation,
    };
  }
}

class EditProfileResponse {
  final bool success;
  final String message;
  final dynamic updatedProfile;

  EditProfileResponse({
    required this.success,
    required this.message,
    this.updatedProfile,
  });

  factory EditProfileResponse.fromJson(Map<String, dynamic> json) {
    return EditProfileResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      updatedProfile: json['updatedProfile'],
    );
  }
}
