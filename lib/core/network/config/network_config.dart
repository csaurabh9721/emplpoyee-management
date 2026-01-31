import 'package:flutter/foundation.dart';

class NetworkConfig {
  ///todo check selected server
  //static const String baseUrl = "http://172.16.5.221:8090"; //local server
 // static const String baseUrl = "http://172.16.7.7:8090/JILITESSAPI"; //private server
 //  static const String baseUrl = "http://117.250.37.227:8090/JILITESSAPI"; //public server
 // static const String baseUrl = "http://ess.jilit.co.in/JILITESSAPI"; //public server with domain
  static const String baseUrl = "http://172.16.7.7:8091"; //testing for token implement
  //static const String login = "/logincontroller/getlogin";
  static const String generateToken = "/token/generate-token";
  static const String forgotPassword = "/token/forgotpassword";
  static const String changePassword = "/clxuser/changepassword";
  static const String dashboard = "/logincontroller/dashboard";
  static const String getSalarySlipView = "/payslipcontroller/getsalaryslipview";
  static const String getSalarySlipReport = "/payslipcontroller/getsalaryslipreport";
  static const String getProfileInfo = "/profilecontroller/getprofileinfo";
  static const String getAddressInfo = "/profilecontroller/getaddressinfo";
  static const String emplLeaveBalance = "/leavecontroller/emplLeaveBalance";
  static const String leaveHistory = "/leavecontroller/leaveHistory";
  static const String leaveDetail = "/leavecontroller/leaveDetail";
  static const String leaveStatus = "/leavecontroller/leaveStatus";
  static const String leaveWithdraw = "/leavecontroller/leaveWithdraw";
  static const String viewLeaveLedger = "/leavecontroller/viewLeaveLedger";
  static const String validateHoliday = "/leavecontroller/validateHoliday";
  static const String checkContinuousPaidLeave = "/leavecontroller/checkContinousPaidLeave";
  static const String leaveSave = "/leavecontroller/leaveSave";
  static const String employeeList = "/leavecontroller/employeeList";
  static const String employeeApprovalList = "/leavecontroller/employeeApprovalList";
  static const String leaveApproval = "/leavecontroller/leaveApproval";
  static const String leaveReject = "/leavecontroller/leaveReject";
  static const String getLeaveLedgerPdfReport = "/leavecontroller/getLeaveLedgerPdfReport";
  static const String getSelfAttendance = "/attendancecontroller/getSelfAttendance";
  static const String getTeamAttendance = "/attendancecontroller/getTeamAttendance";
  static const String getAccountBalance = "/accountbalance/getaccountbalance";
  static const String subGlCode = "/accountbalance/subglcode";
  static const String viewAccountLedger = "/accountbalance/viewAccountLedger";
  static const String downloadAccountLedgerReport = "/accountbalance/downloadAccountLedgerReport";



  static Uri getUrl(String url) {
    final String fullUrl = baseUrl + url;
    final Uri uri = Uri.parse(fullUrl);
    debugPrint(uri.toString());
    return uri;
  }
}
