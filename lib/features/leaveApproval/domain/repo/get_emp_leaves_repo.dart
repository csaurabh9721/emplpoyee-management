import '../entity/employee_leave_list.dart';

abstract class GetEmpLeavesRepo {
  Future<List<EmployeeLeaveList>> getLeaves(String empId);
}
