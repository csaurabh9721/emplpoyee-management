import 'package:clientone_ess/core/exceptions/api_exceptions.dart';
import 'package:clientone_ess/features/leaveApproval/domain/entity/employee_list_entity.dart';
import '../../domain/repo/get_emp_list_repo.dart';
import '../models/employee_list_model_for_approval.dart';
import '../dataSource/employee_list_source.dart';

class GetEmpListRepoImpl extends GetEmpListRepo {
  GetEmpListRepoImpl(this._remoteLeaveBalanceSource);
  final EmployeeListSource _remoteLeaveBalanceSource;

  @override
  Future<List<EmployeeListEntity>> getEmployeeList() async {
    final EmployeeListModelForApproval response =
        await _remoteLeaveBalanceSource.getData();
    if (response.statusCode > 299 || response.statusCode < 200) {
      throw AppException(response.message);
    }
    if (response.entity == null) {
      throw AppException(response.message);
    }
    return response.dtoToEntity();
  }
}
