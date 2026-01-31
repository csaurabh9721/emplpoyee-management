import 'package:clientone_ess/core/exceptions/api_exceptions.dart';
import 'package:clientone_ess/core/network/apiClients/post_api_base.dart';
import 'package:clientone_ess/core/network/config/network_config.dart';
import 'package:clientone_ess/core/service/sessionManagement/sessions.dart';

import '../models/employee_approval_list_model.dart';

abstract class EmployeeApprovalListSource {
  Future<EmployeeApprovalListModel> getData(String empId);
}

class EmployeeApprovalListSourceImpl implements EmployeeApprovalListSource {
  @override
  Future<EmployeeApprovalListModel> getData(String empId) async {
    try {
      final Map<String, String> body = {
        "aaprovalEmployeeId": Sessions.getEmployeeId(),
        "payrollareaid": Sessions.getPayrollAreaId(),
        "selectedEmployeeId": empId,
      };
      final Map<String, dynamic> json = await PostApiBase.instance
          .post(url: "", body: body);
      return EmployeeApprovalListModel.fromJson(json);
    } catch (e) {
      throw AppException(e.toString());
    }
  }
}
