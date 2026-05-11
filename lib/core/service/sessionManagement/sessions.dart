import 'package:get_storage/get_storage.dart';
import 'package:clientone_ess/core/service/sessionManagement/session_keys.dart';

class Sessions {
  static final GetStorage _box = GetStorage();

  static void setUserId(int value) {
    _box.write(SessionKeys.userId, value);
  }

  static void setEmpName(String value) {
    _box.write(SessionKeys.employeeName, value);
  }

  static void setEmployeeCode(String value) {
    _box.write(SessionKeys.employeeCode, value);
  }

  static void setAccessToken(String value) {
    _box.write(SessionKeys.accessToken, value);
  }

  static void setRefreshToken(String value) {
    _box.write(SessionKeys.refreshToken, value);
  }

  // Getters

  static int getUserId() {
    return _box.read(SessionKeys.userId) ?? 0;
  }

  static String getEmpName() {
    return _box.read(SessionKeys.employeeName);
  }

  static String getEmployeeCode() {
    return _box.read(SessionKeys.employeeCode) ?? "";
  }

  static String getAccessToken() {
    return _box.read(SessionKeys.accessToken) ?? "";
  }

  static String getRefreshToken() {
    return _box.read(SessionKeys.refreshToken) ?? "";
  }

  static bool isLoggedIn() {
    return _box.read(SessionKeys.userId) != null;
  }

  static void erase() {
    final String getEmpCode = getEmployeeCode();
    _box.erase();
    if (getEmpCode != "") {
      setEmployeeCode(getEmpCode);
    }
  }
}
