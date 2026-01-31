import 'package:get_storage/get_storage.dart';
import 'package:clientone_ess/core/service/sessionManagement/session_keys.dart';

class Sessions {
  static final GetStorage _box = GetStorage();

  // Setters
  static void setPayrollAreaCode(String value) {
    _box.write(SessionKeys.payrollAreaCode, value);
  }

  static void setPayrollAreaId(String value) {
    _box.write(SessionKeys.payrollAreaId, value);
  }

  static void setCompanyId(String value) {
    _box.write(SessionKeys.companyId, value);
  }

  static void setPayrollUniqueId(String value) {
    _box.write(SessionKeys.payrollUniqueId, value);
  }

  static void setUserId(String value) {
    _box.write(SessionKeys.userId, value);
  }

  static void setEmployeeId(String value) {
    _box.write(SessionKeys.employeeId, value);
  }

  static void setEmployeeCode(String value) {
    _box.write(SessionKeys.employeeCode, value);
  }

  static void setPlaceOfPostingId(String value) {
    _box.write(SessionKeys.placeOfPostingID, value);
  }

  static void setEmployeeTypeId(String value) {
    _box.write(SessionKeys.employeeTypeId, value);
  }

  static void setProfitCentreId(String value) {
    _box.write(SessionKeys.profitCentreId, value);
  }

  static void setProfitCentreCode(String value) {
    _box.write(SessionKeys.profitCentreCode, value);
  }

  static void setToken(String value) {
    _box.write(SessionKeys.token, value);
  }

  static void setMemberType(String value) {
    _box.write(SessionKeys.memberType, value);
  }

  // Getters
  static String getPayrollAreaCode() {
    return _box.read(SessionKeys.payrollAreaCode) ?? "";
  }

  static String getPayrollAreaId() {
    return _box.read(SessionKeys.payrollAreaId) ?? "";
  }

  static String getCompanyId() {
    return _box.read(SessionKeys.companyId) ?? "";
  }

  static String getPayrollUniqueId() {
    return _box.read(SessionKeys.payrollUniqueId) ?? "";
  }

  static String getUserId() {
    return _box.read(SessionKeys.userId);
  }

  static String getEmployeeId() {
    return _box.read(SessionKeys.employeeId) ?? "";
  }

  static String getEmployeeCode() {
    return _box.read(SessionKeys.employeeCode) ?? "";
  }

  static String getPlaceOfPostingId() {
    return _box.read(SessionKeys.placeOfPostingID) ?? "";
  }

  static String getEmployeeTypeId() {
    return _box.read(SessionKeys.employeeTypeId) ?? "";
  }

  static String getProfitCentreId() {
    return _box.read(SessionKeys.profitCentreId) ?? "";
  }

  static String getProfitCentreCode() {
    return _box.read(SessionKeys.profitCentreCode) ?? "";
  }

  static String getToken() {
    return _box.read(SessionKeys.token) ?? "";
  }

  static String getMemberType() {
    return _box.read(SessionKeys.memberType) ?? "E";
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
