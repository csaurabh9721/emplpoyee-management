import 'package:clientone_ess/features/leaveApproval/domain/entity/employee_list_entity.dart';

abstract class GetEmpListRepo {
  Future<List<EmployeeListEntity>> getEmployeeList();
}
