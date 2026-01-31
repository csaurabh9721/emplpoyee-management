import 'package:clientone_ess/features/leaveApproval/domain/entity/employee_leave_list.dart';

import '../../../../core/exceptions/api_exceptions.dart';
import '../../domain/repo/get_emp_leaves_repo.dart';
import '../dataSource/employee_approval_list_source.dart';
import '../models/employee_approval_list_model.dart';

class GetEmpLeavesRepoImpl implements GetEmpLeavesRepo {
  GetEmpLeavesRepoImpl(this._source);
  final EmployeeApprovalListSource _source;

  @override
  Future<List<EmployeeLeaveList>> getLeaves(String empId) async {
    final EmployeeApprovalListModel response = await _source.getData(empId);
    if (response.statusCode > 299 || response.statusCode < 200) {
      throw AppException(response.message);
    }
    if (response.entity == null) {
      throw AppException(response.message);
    }
    return response.toEntity();
  }
}
