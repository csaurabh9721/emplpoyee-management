import 'dart:convert';
import 'dart:typed_data';

class ProfileResponseEntity {

  ProfileResponseEntity({
    required this.userId,
    required this.personalDetails,
    required this.accountDetails,
    required this.emergencyContact,
    required this.permanentAddress,
    required this.correspondenceAddress,
  });
  final String userId;
  final PersonalDetailsEntity personalDetails;
  final AccountDetailsEntity accountDetails;
  final EmergencyContactEntity emergencyContact;
  final AddressEntity permanentAddress;
  final AddressEntity correspondenceAddress;
}

class PersonalDetailsEntity {

  PersonalDetailsEntity({
    required this.profileImage,
    required this.name,
    required this.fatherName,
    required this.motherName,
    required this.spouseName,
    required this.aadhaarNo,
    required this.email,
    required this.dob,
    required this.bloodGroup,
    required this.gender,
    required this.empCode,
    required this.doj,
    required this.grade,
    required this.designation,
    required this.department,
  });
  final String profileImage;
  final String fatherName;
  final String name;
  final String motherName;
  final String spouseName;
  final String aadhaarNo;
  final String email;
  final String dob;
  final String bloodGroup;
  final String gender;
  final String empCode;
  final String doj;
  final String grade;
  final String designation;
  final String department;

  Uint8List get bytes => base64Decode(profileImage);
}

class AccountDetailsEntity {

  AccountDetailsEntity({
    required this.uanNo,
    required this.pfNo,
    required this.bankAccountNo,
    required this.ifscCode,
    required this.bankName,
  });
  final String uanNo;
  final String pfNo;
  final String bankAccountNo;
  final String ifscCode;
  final String bankName;
}

class EmergencyContactEntity {

  EmergencyContactEntity({
    required this.name,
    required this.mobile,
    required this.relation,
  });
  final String name;
  final String mobile;
  final String relation;
}

class AddressEntity {

  AddressEntity({
    required this.address,
    required this.district,
    required this.city,
    required this.postalCode,
    required this.state,
    required this.country,
  });
  final String address;
  final String district;
  final String city;
  final String postalCode;
  final String state;
  final String country;
}
