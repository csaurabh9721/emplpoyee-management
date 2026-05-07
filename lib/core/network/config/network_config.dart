import 'package:flutter/foundation.dart';

class NetworkConfig {
  //static const String _baseUrl = "http://172.16.173.247:8080";
  static const String _baseUrl = "http://10.17.103.64:8080";
  static const String login = "/api/auth/login";
  static const String getEmployeeProfile = "/api/employees/getEmployeeProfile";
  static const String updateProfile = "/api/employees/update-profile";
  static const String dashboardData = "/api/dashboard/dashboardData";
  static const String punchInOut = "/api/attendance/punchInOut";
  static const String getAttendanceByDateRange =
      "/api/attendance/getAttendanceByDateRange";
  static const String getAllHolidays = "/api/holidays/getAll/";
  static const String getLeaveBalance = "/api/leaveBalance/getLeave";
  static const String getLeaveType = "/api/leaveBalance/getLeaveType";
  static const String leaveApply = "/api/leaves/apply";
  static const String getLeaveForEmployee = "/api/leaves/getLeaveForEmployee";
  static const String getLeaveForApproval = "/api/leaves/getLeaveForApproval";
  static const String leaveApprove = "/api/leaves/approve";
  static const String leaveReject = "/api/leaves/reject";
  static const String leaveWithdrawn = "/api/leaves/Withdrawn";
  static const String getAttendanceForMangerByDateRange = "/api/attendance/getAttendanceForMangerByDateRange";

  static Uri getUrl(String url) {
    final String fullUrl = _baseUrl + url;
    final Uri uri = Uri.parse(fullUrl);
    debugPrint(uri.toString());
    return uri;
  }
}
