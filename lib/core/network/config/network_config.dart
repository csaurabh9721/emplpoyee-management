import 'package:flutter/foundation.dart';

class NetworkConfig {
  //static const String _baseUrl = "http://172.16.173.247:8080";
 // static const String _baseUrl = "http://10.92.66.194:8080";
  static const String _baseUrl = "http://10.92.66.64:8080";
  static const String login = "/api/auth/login";
  static const String getEmployeeProfile = "/api/employees/getEmployeeProfile";
  static const String updateProfile = "/api/employees/update-profile";
  static const String dashboardData = "/api/dashboard/dashboardData";
  static const String punchInOut = "/api/attendance/punchInOut";
  static const String getAttendanceByEmployeeId = "/api/attendance/getAttendanceByEmployeeId";

  static Uri getUrl(String url) {
    final String fullUrl = _baseUrl + url;
    final Uri uri = Uri.parse(fullUrl);
    debugPrint(uri.toString());
    return uri;
  }
}
