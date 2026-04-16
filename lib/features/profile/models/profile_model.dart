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
        statusCode: json["statusCode"] ?? 0,
        message: json["message"] ?? "",
        body: json["body"] != null ? ProfileModelBody.fromJson(json["body"]) : ProfileModelBody.empty(),
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
  final String phone;

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
    required this.phone,
  });

  factory ProfileModelBody.fromJson(Map<String, dynamic> json) => ProfileModelBody(
        id: json["id"] ?? 0,
        employeeCode: json["employeeCode"] ?? "",
        fullName: json["fullName"] ?? "",
        designation: json["designation"] != null ? Designation.fromJson(json["designation"]) : Designation.empty(),
        department: json["department"] ?? "",
        profileImageUrl: json["profileImageUrl"] ?? "",
        joiningDate:
            json["joiningDate"] != null ? DateTime.tryParse(json["joiningDate"]) ?? DateTime.now() : DateTime.now(),
        status: json["status"] ?? "",
        userId: json["userId"] ?? 0,
        organizationId: json["organizationId"] ?? 0,
        primaryOfficeId: json["primaryOfficeId"] ?? 0,
        organizationName: json["organizationName"] ?? "",
        primaryOfficeName: json["primaryOfficeName"] ?? "",
        personalDetails: json["personalDetails"] != null
            ? PersonalDetails.fromJson(json["personalDetails"])
            : PersonalDetails.empty(),
        employeeAddress: json["employeeAddress"] != null
            ? EmployeeAddress.fromJson(json["employeeAddress"])
            : EmployeeAddress.empty(),
        emergencyContact: json["emergencyContact"] != null
            ? EmergencyContact.fromJson(json["emergencyContact"])
            : EmergencyContact.empty(),
        employeeBankDetails: json["employeeBankDetails"] != null
            ? EmployeeBankDetails.fromJson(json["employeeBankDetails"])
            : EmployeeBankDetails.empty(),
        employeeEmploymentDetails: json["employeeEmploymentDetails"] != null
            ? EmployeeEmploymentDetails.fromJson(json["employeeEmploymentDetails"])
            : EmployeeEmploymentDetails.empty(),
        employmentType: json["employmentType"] ?? "",
        managerId: json["managerId"] ?? 0,
        managerName: json["managerName"] ?? "",
        phone: json["phone"] ?? "",
      );

  factory ProfileModelBody.empty() => ProfileModelBody(
        id: 0,
        employeeCode: "",
        fullName: "",
        designation: Designation.empty(),
        department: "",
        profileImageUrl: "",
        joiningDate: DateTime.now(),
        status: "",
        userId: 0,
        organizationId: 0,
        primaryOfficeId: 0,
        organizationName: "",
        primaryOfficeName: "",
        personalDetails: PersonalDetails.empty(),
        employeeAddress: EmployeeAddress.empty(),
        emergencyContact: EmergencyContact.empty(),
        employeeBankDetails: EmployeeBankDetails.empty(),
        employeeEmploymentDetails: EmployeeEmploymentDetails.empty(),
        employmentType: "",
        managerId: 0,
        managerName: "",
        phone: "",
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
        id: json["id"] ?? 0,
        name: json["name"] ?? "",
        description: json["description"] ?? "",
      );

  factory Designation.empty() => Designation(
        id: 0,
        name: "",
        description: "",
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
        id: json["id"] ?? 0,
        name: json["name"] ?? "",
        phone: json["phone"] ?? "",
        relation: json["relation"] ?? "",
      );

  factory EmergencyContact.empty() => EmergencyContact(
        id: 0,
        name: "",
        phone: "",
        relation: "",
      );
}

class EmployeeAddress {
  final int id;
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

  EmployeeAddress({
    required this.id,
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
  });

  factory EmployeeAddress.fromJson(Map<String, dynamic> json) => EmployeeAddress(
        id: json["id"] ?? 0,
        address: json["address"] ?? "",
        city: json["city"] ?? "",
        state: json["state"] ?? "",
        postalCode: json["postalCode"] ?? "",
        country: json["country"] ?? "",
        permanentAddress: json["permanentAddress"] ?? "",
        permanentCity: json["permanentCity"] ?? "",
        permanentState: json["permanentState"] ?? "",
        permanentPostalCode: json["permanentPostalCode"] ?? "",
        permanentCountry: json["permanentCountry"] ?? "",
      );

  factory EmployeeAddress.empty() => EmployeeAddress(
        id: 0,
        address: "",
        city: "",
        state: "",
        postalCode: "",
        country: "",
        permanentAddress: "",
        permanentCity: "",
        permanentState: "",
        permanentPostalCode: "",
        permanentCountry: "",
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
        id: json["id"] ?? 0,
        bankName: json["bankName"] ?? "",
        accountNumber: json["accountNumber"] ?? "",
        ifscCode: json["ifscCode"] ?? "",
      );

  factory EmployeeBankDetails.empty() => EmployeeBankDetails(
        id: 0,
        bankName: "",
        accountNumber: "",
        ifscCode: "",
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
        id: json["id"] ?? 0,
        pfNumber: json["pfNumber"] ?? "",
        esiNumber: json["esiNumber"] ?? "",
      );

  factory EmployeeEmploymentDetails.empty() => EmployeeEmploymentDetails(
        id: 0,
        pfNumber: "",
        esiNumber: "",
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
  final String personalEmail;
  final String alternateMobileNumber;

  PersonalDetails({
    required this.id,
    required this.dateOfBirth,
    required this.gender,
    required this.maritalStatus,
    required this.bloodGroup,
    required this.panNumber,
    required this.aadharNumber,
    required this.personalEmail,
    required this.alternateMobileNumber,
  });

  factory PersonalDetails.fromJson(Map<String, dynamic> json) => PersonalDetails(
        id: json["id"] ?? 0,
        dateOfBirth:
            json["dateOfBirth"] != null ? DateTime.tryParse(json["dateOfBirth"]) ?? DateTime.now() : DateTime.now(),
        gender: json["gender"] ?? "",
        maritalStatus: json["maritalStatus"] ?? "",
        bloodGroup: json["bloodGroup"] ?? "",
        panNumber: json["panNumber"] ?? "",
        aadharNumber: json["aadharNumber"] ?? "",
        personalEmail: json["personalEmail"] ?? "",
        alternateMobileNumber: json["alternateMobileNumber"] ?? "",
      );

  factory PersonalDetails.empty() => PersonalDetails(
        id: 0,
        dateOfBirth: DateTime.now(),
        gender: "",
        maritalStatus: "",
        bloodGroup: "",
        panNumber: "",
        aadharNumber: "",
        personalEmail: "",
        alternateMobileNumber: "",
      );

  String get formattedDob {
    return DateFormat('dd/MM/yyyy').format(dateOfBirth);
  }
}
