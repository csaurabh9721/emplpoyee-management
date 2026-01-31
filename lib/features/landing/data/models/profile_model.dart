class ProfileInfoModel {

  ProfileInfoModel({
    required this.profileInfo,
    required this.message,
    required this.status,
  });

  factory ProfileInfoModel.fromJson(Map<String, dynamic> json) => ProfileInfoModel(
        profileInfo: json["profileInfo"] != null ? ProfileInfo.fromJson(json["profileInfo"]) : null,
        message: json["message"] ?? "Something went wrong",
        status: json["status"] ?? 400,
      );
  final ProfileInfo? profileInfo;
  final String message;
  final int status;
}

class ProfileInfo {

  ProfileInfo({
    required this.dateofbirth,
    required this.employeephoto,
    required this.emergencycontactnumber,
    required this.bankname,
    required this.emergencycontactrelationship,
    required this.gender,
    required this.mobileno,
    required this.departmentname,
    required this.ifsccode,
    required this.aadharno,
    required this.uanno,
    required this.panno,
    required this.fathername,
    required this.mothername,
    required this.departmentid,
    required this.designationcode,
    required this.employeecode,
    required this.departmentcode,
    required this.employeetype,
    required this.emergencycontactname,
    required this.pfnumber,
    required this.bankcode,
    required this.gradecode,
    required this.spousename,
    required this.designationname,
    required this.bankaccountno,
    required this.employeename,
    required this.dateofjoining,
    required this.bloodgroup,
    required this.emailid,
  });

  factory ProfileInfo.fromJson(Map<String, dynamic> json) => ProfileInfo(
        dateofbirth: json["dateofbirth"] ?? "",
        employeephoto: json["employeephoto"] ?? "",
        emergencycontactnumber: json["emergencycontactnumber"] ?? "",
        bankname: json["bankname"] ?? "",
        emergencycontactrelationship: json["emergencycontactrelationship"] ?? "",
        gender: json["gender"] ?? "",
        mobileno: json["mobileno"] ?? "",
        departmentname: json["departmentname"] ?? "",
        ifsccode: json["ifsccode"] ?? "",
        aadharno: json["aadharno"] ?? "",
        uanno: json["uanno"] ?? "",
        panno: json["panno"] ?? "",
        fathername: json["fathername"] ?? "",
        mothername: json["mothername"] ?? "",
        departmentid: json["departmentid"] ?? "",
        designationcode: json["designationcode"] ?? "",
        employeecode: json["employeecode"] ?? "",
        departmentcode: json["departmentcode"] ?? "",
        employeetype: json["employeetype"] ?? "",
        emergencycontactname: json["emergencycontactname"] ?? "",
        pfnumber: json["pfnumber"] ?? "",
        bankcode: json["bankcode"] ?? "",
        gradecode: json["gradecode"] ?? "",
        spousename: json["spousename"] ?? "",
        designationname: json["designationname"] ?? "",
        bankaccountno: json["bankaccountno"] ?? "",
        employeename: json["employeename"] ?? "",
        dateofjoining: json["dateofjoining"] ?? "",
        bloodgroup: json["bloodgroup"] ?? "",
        emailid: json["emailid"] ?? "",
      );
  final String dateofbirth;
  final String employeephoto;
  final String emergencycontactnumber;
  final String bankname;
  final String emergencycontactrelationship;
  final String gender;
  final String mobileno;
  final String departmentname;
  final String ifsccode;
  final String aadharno;
  final String uanno;
  final String panno;
  final String fathername;
  final String mothername;
  final String departmentid;
  final String designationcode;
  final String employeecode;
  final String departmentcode;
  final String employeetype;
  final String emergencycontactname;
  final String pfnumber;
  final String bankcode;
  final String gradecode;
  final String spousename;
  final String designationname;
  final String bankaccountno;
  final String employeename;
  final String dateofjoining;
  final String bloodgroup;
  final String emailid;
}
