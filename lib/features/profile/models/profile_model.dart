import 'package:intl/intl.dart';

class ProfileModel {
  final int statusCode;
  final String message;
  final ProfileModelBody body;

  ProfileModel({
    required this.statusCode,
    required this.message,
    required this.body,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
        statusCode: json["statusCode"],
        message: json["message"],
        body: ProfileModelBody.fromJson(json["body"]),
      );
}

class ProfileModelBody {
  final int id;
  final String employeeCode;
  final String fullName;
  final Designation designation;
  final String department;
  final String profileImageUrl;
  final DateTime joiningDate;
  final String status;
  final int userId;
  final int organizationId;
  final int primaryOfficeId;
  final String organizationName;
  final String primaryOfficeName;
  final PersonalDetails personalDetails;
  final EmployeeAddress employeeAddress;
  final EmergencyContact emergencyContact;
  final EmployeeBankDetails employeeBankDetails;
  final EmployeeEmploymentDetails employeeEmploymentDetails;
  final String employmentType;
  final int managerId;
  final String managerName;
  ProfileModelBody({
    required this.id,
    required this.employeeCode,
    required this.fullName,
    required this.designation,
    required this.department,
    required this.profileImageUrl,
    required this.joiningDate,
    required this.status,
    required this.userId,
    required this.organizationId,
    required this.primaryOfficeId,
    required this.organizationName,
    required this.primaryOfficeName,
    required this.personalDetails,
    required this.employeeAddress,
    required this.emergencyContact,
    required this.employeeBankDetails,
    required this.employeeEmploymentDetails,
    required this.employmentType,
    required this.managerId,
    required this.managerName,
  });

  factory ProfileModelBody.fromJson(Map<String, dynamic> json) => ProfileModelBody(
        id: json["id"],
        employeeCode: json["employeeCode"],
        fullName: json["fullName"],
        designation: Designation.fromJson(json["designation"]),
        department: json["department"],
        profileImageUrl: json["profileImageUrl"],
        joiningDate: DateTime.parse(json["joiningDate"]),
        status: json["status"],
        userId: json["userId"],
        organizationId: json["organizationId"],
        primaryOfficeId: json["primaryOfficeId"],
        organizationName: json["organizationName"],
        primaryOfficeName: json["primaryOfficeName"],
        personalDetails: PersonalDetails.fromJson(json["personalDetails"]),
        employeeAddress: EmployeeAddress.fromJson(json["employeeAddress"]),
        emergencyContact: EmergencyContact.fromJson(json["emergencyContact"]),
        employeeBankDetails: EmployeeBankDetails.fromJson(json["employeeBankDetails"]),
        employeeEmploymentDetails: EmployeeEmploymentDetails.fromJson(json["employeeEmploymentDetails"]),
        employmentType: json["employmentType"],
        managerId: json["managerId"],
        managerName: json["managerName"],
      );



  String get formattedJoiningDate {
    return DateFormat('dd/MM/yyyy').format(joiningDate);
  }
}

class Designation {
  final int id;
  final String name;
  final String description;

  Designation({
    required this.id,
    required this.name,
    required this.description,
  });

  factory Designation.fromJson(Map<String, dynamic> json) => Designation(
        id: json["id"],
        name: json["name"],
        description: json["description"],
      );
}

class EmergencyContact {
  final int id;
  final String name;
  final String phone;
  final String relation;

  EmergencyContact({
    required this.id,
    required this.name,
    required this.phone,
    required this.relation,
  });

  factory EmergencyContact.fromJson(Map<String, dynamic> json) => EmergencyContact(
        id: json["id"],
        name: json["name"],
        phone: json["phone"],
        relation: json["relation"],
      );
}

class EmployeeAddress {
  final int id;
  final String address;
  final String city;
  final String state;
  final String postalCode;
  final String country;

  EmployeeAddress({
    required this.id,
    required this.address,
    required this.city,
    required this.state,
    required this.postalCode,
    required this.country,
  });

  factory EmployeeAddress.fromJson(Map<String, dynamic> json) => EmployeeAddress(
        id: json["id"],
        address: json["address"],
        city: json["city"],
        state: json["state"],
        postalCode: json["postalCode"],
        country: json["country"],
      );
}

class EmployeeBankDetails {
  final int id;
  final String bankName;
  final String accountNumber;
  final String ifscCode;

  EmployeeBankDetails({
    required this.id,
    required this.bankName,
    required this.accountNumber,
    required this.ifscCode,
  });

  factory EmployeeBankDetails.fromJson(Map<String, dynamic> json) => EmployeeBankDetails(
        id: json["id"],
        bankName: json["bankName"],
        accountNumber: json["accountNumber"],
        ifscCode: json["ifscCode"],
      );
}

class EmployeeEmploymentDetails {
  final int id;
  final String pfNumber;
  final String esiNumber;

  EmployeeEmploymentDetails({
    required this.id,
    required this.pfNumber,
    required this.esiNumber,
  });

  factory EmployeeEmploymentDetails.fromJson(Map<String, dynamic> json) => EmployeeEmploymentDetails(
        id: json["id"],
        pfNumber: json["pfNumber"],
        esiNumber: json["esiNumber"],
      );
}

class PersonalDetails {
  final int id;
  final DateTime dateOfBirth;
  final String gender;
  final String maritalStatus;
  final String bloodGroup;
  final String panNumber;
  final String aadharNumber;

  PersonalDetails({
    required this.id,
    required this.dateOfBirth,
    required this.gender,
    required this.maritalStatus,
    required this.bloodGroup,
    required this.panNumber,
    required this.aadharNumber,
  });

  factory PersonalDetails.fromJson(Map<String, dynamic> json) => PersonalDetails(
        id: json["id"],
        dateOfBirth: DateTime.parse(json["dateOfBirth"]),
        gender: json["gender"],
        maritalStatus: json["maritalStatus"],
        bloodGroup: json["bloodGroup"],
        panNumber: json["panNumber"],
        aadharNumber: json["aadharNumber"],
      );
  String get formattedDob {
    return DateFormat('dd/MM/yyyy').format(dateOfBirth);
  }
}
