class ProfileModel {
  final String employeeId;
  final String firstName;
  final String lastName;
  final String email;
  final String phone;
  final String department;
  final String designation;
  final String dateOfJoining;
  final String employmentType;
  final String workLocation;
  final String manager;
  final String profileImage;
  final String address;
  final String city;
  final String state;
  final String postalCode;
  final String country;
  final String emergencyContactName;
  final String emergencyContactPhone;
  final String emergencyContactRelation;
  final String bloodGroup;
  final String dateOfBirth;
  final String gender;
  final String maritalStatus;
  final String panNumber;
  final String aadharNumber;
  final String bankName;
  final String bankAccountNumber;
  final String bankIfscCode;
  final String pfNumber;
  final String esiNumber;

  ProfileModel({
    required this.employeeId,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
    required this.department,
    required this.designation,
    required this.dateOfJoining,
    required this.employmentType,
    required this.workLocation,
    required this.manager,
    required this.profileImage,
    required this.address,
    required this.city,
    required this.state,
    required this.postalCode,
    required this.country,
    required this.emergencyContactName,
    required this.emergencyContactPhone,
    required this.emergencyContactRelation,
    required this.bloodGroup,
    required this.dateOfBirth,
    required this.gender,
    required this.maritalStatus,
    required this.panNumber,
    required this.aadharNumber,
    required this.bankName,
    required this.bankAccountNumber,
    required this.bankIfscCode,
    required this.pfNumber,
    required this.esiNumber,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      employeeId: json['employeeId'] ?? '',
      firstName: json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'] ?? '',
      department: json['department'] ?? '',
      designation: json['designation'] ?? '',
      dateOfJoining: json['dateOfJoining'] ?? '',
      employmentType: json['employmentType'] ?? '',
      workLocation: json['workLocation'] ?? '',
      manager: json['manager'] ?? '',
      profileImage: json['profileImage'] ?? '',
      address: json['address'] ?? '',
      city: json['city'] ?? '',
      state: json['state'] ?? '',
      postalCode: json['postalCode'] ?? '',
      country: json['country'] ?? '',
      emergencyContactName: json['emergencyContactName'] ?? '',
      emergencyContactPhone: json['emergencyContactPhone'] ?? '',
      emergencyContactRelation: json['emergencyContactRelation'] ?? '',
      bloodGroup: json['bloodGroup'] ?? '',
      dateOfBirth: json['dateOfBirth'] ?? '',
      gender: json['gender'] ?? '',
      maritalStatus: json['maritalStatus'] ?? '',
      panNumber: json['panNumber'] ?? '',
      aadharNumber: json['aadharNumber'] ?? '',
      bankName: json['bankName'] ?? '',
      bankAccountNumber: json['bankAccountNumber'] ?? '',
      bankIfscCode: json['bankIfscCode'] ?? '',
      pfNumber: json['pfNumber'] ?? '',
      esiNumber: json['esiNumber'] ?? '',
    );
  }

  String get fullName => '$firstName $lastName';
}
