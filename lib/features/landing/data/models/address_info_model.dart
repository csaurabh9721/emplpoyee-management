class AddressInfoModel {

  AddressInfoModel({
    required this.addressInfo,
    required this.message,
    required this.status,
  });

  factory AddressInfoModel.fromJson(Map<String, dynamic> json) => AddressInfoModel(
        addressInfo: json["addressInfo"] == null ? null : AddressInfo.fromJson(json["addressInfo"]),
        message: json["message"] ?? "",
        status: json["status"] ?? 0,
      );
  final AddressInfo? addressInfo;
  final String message;
  final int status;
}

class AddressInfo {

  AddressInfo({
    required this.permanentmobileno,
    required this.permanentphone,
    required this.currentaddress3,
    required this.currentstatename,
    required this.currentaddress2,
    required this.permanentcityname,
    required this.permanentstatename,
    required this.currentcountryname,
    required this.currentpin,
    required this.permanentpin,
    required this.permanentaddress2,
    required this.permanentaddress3,
    required this.permanentcountryname,
    required this.permanentaddress1,
    required this.currentphoneno,
    required this.employeename,
    required this.currentdistrict,
    required this.currentaddress1,
    required this.currentcityname,
    required this.permanentdistrict,
  });

  factory AddressInfo.fromJson(Map<String, dynamic> json) => AddressInfo(
        permanentmobileno: json["permanentmobileno"] ?? "",
        permanentphone: json["permanentphone"] ?? "",
        currentaddress3: json["currentaddress3"] ?? "",
        currentstatename: json["currentstatename"] ?? "",
        currentaddress2: json["currentaddress2"] ?? "",
        permanentcityname: json["permanentcityname"] ?? "",
        permanentstatename: json["permanentstatename"] ?? "",
        currentcountryname: json["currentcountryname"] ?? "",
        currentpin: json["currentpin"] ?? 0,
        permanentpin: json["permanentpin"] ?? 0,
        permanentaddress2: json["permanentaddress2"] ?? "",
        permanentaddress3: json["permanentaddress3"] ?? "",
        permanentcountryname: json["permanentcountryname"] ?? "",
        permanentaddress1: json["permanentaddress1"] ?? "",
        currentphoneno: json["currentphoneno"] ?? "",
        employeename: json["employeename"] ?? "",
        currentdistrict: json["currentdistrict"] ?? "",
        currentaddress1: json["currentaddress1"] ?? "",
        currentcityname: json["currentcityname"] ?? "",
        permanentdistrict: json["permanentdistrict"] ?? "",
      );
  final String permanentmobileno;
  final String permanentphone;
  final String currentaddress3;
  final String currentstatename;
  final String currentaddress2;
  final String permanentcityname;
  final String permanentstatename;
  final String currentcountryname;
  final int currentpin;
  final int permanentpin;
  final String permanentaddress2;
  final String permanentaddress3;
  final String permanentcountryname;
  final String permanentaddress1;
  final String currentphoneno;
  final String employeename;
  final String currentdistrict;
  final String currentaddress1;
  final String currentcityname;
  final String permanentdistrict;
}
