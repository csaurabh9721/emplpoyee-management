class EditProfileRequest {
  final int employeeId;
  final String fullName;
  final String personalEmail;
  final String alternateMobileNumber;
  final String gender;
  final String maritalStatus;
  final String bloodGroup;
  final String address;
  final String city;
  final String state;
  final String postalCode;
  final String country;
  final String permanentAddress;
  final String permanentCity;
  final String permanentState;
  final String permanentPostalCode;
  final String permanentCountry;
  final String emergencyName;
  final String emergencyPhone;
  final String emergencyRelation;

  EditProfileRequest({
    required this.employeeId,
    required this.fullName,
    required this.personalEmail,
    required this.alternateMobileNumber,
    required this.gender,
    required this.maritalStatus,
    required this.bloodGroup,
    required this.address,
    required this.city,
    required this.state,
    required this.postalCode,
    required this.country,
    required this.permanentAddress,
    required this.permanentCity,
    required this.permanentState,
    required this.permanentPostalCode,
    required this.permanentCountry,
    required this.emergencyName,
    required this.emergencyPhone,
    required this.emergencyRelation,
  });

  Map<String, dynamic> toJson() {
    return {
      'employeeId': employeeId,
      'fullName': fullName,
      'personalEmail': personalEmail,
      'alternateMobileNumber': alternateMobileNumber,
      'gender': gender,
      'maritalStatus': maritalStatus,
      'bloodGroup': bloodGroup,
      'address': address,
      'city': city,
      'state': state,
      'postalCode': postalCode,
      'country': country,
      'permanentAddress': permanentAddress,
      'permanentCity': permanentCity,
      'permanentState': permanentState,
      'permanentPostalCode': permanentPostalCode,
      'permanentCountry': permanentCountry,
      'emergencyName': emergencyName,
      'emergencyPhone': emergencyPhone,
      'emergencyRelation': emergencyRelation,
    };
  }
}
