import 'package:clientone_ess/core/exceptions/api_exceptions.dart';
import 'package:clientone_ess/core/network/apiClients/post_api_base.dart';
import 'package:clientone_ess/core/network/config/network_config.dart';
import 'package:clientone_ess/core/service/sessionManagement/sessions.dart';

import '../models/employee_list_model_for_approval.dart';

abstract class EmployeeListSource {
  Future<EmployeeListModelForApproval> getData();
}

class EmployeeListSourceImpl implements EmployeeListSource {
  @override
  Future<EmployeeListModelForApproval> getData() async {
    try {
      final Map<String, String> body = {
        "employeeid": Sessions.getEmployeeId(),
        "payrollareaid": Sessions.getPayrollAreaId()
      };
      final Map<String, dynamic> json = await PostApiBase.instance
          .post(url: "", body: body);
      return EmployeeListModelForApproval.fromJson(json);
    } catch (e) {
      throw AppException(e.toString());
    }
  }
}
