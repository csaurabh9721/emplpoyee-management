import 'package:get_storage/get_storage.dart';
import 'package:clientone_ess/core/service/sessionManagement/session_keys.dart';

class Sessions {
  static final GetStorage _box = GetStorage();







  static void setUserId(String value) {
    _box.write(SessionKeys.userId, value);
  }


  static void setEmployeeCode(String value) {
    _box.write(SessionKeys.employeeCode, value);
  }

  static void setToken(String value) {
    _box.write(SessionKeys.token, value);
  }



  // Getters


  static String getUserId() {
    return _box.read(SessionKeys.userId);
  }

  static String getEmployeeCode() {
    return _box.read(SessionKeys.employeeCode) ?? "";
  }



  static String getToken() {
    return _box.read(SessionKeys.token) ?? "";
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
