import '../entity/employee_leave_list.dart';
import '../repo/get_emp_leaves_repo.dart';

abstract class GetEmpLeaveUsecase {
  Future<List<EmployeeLeaveList>> call(String empId);
}

class GetEmpLeaveUsecaseImpl implements GetEmpLeaveUsecase {

  GetEmpLeaveUsecaseImpl(this._repo);
  final GetEmpLeavesRepo _repo;

  @override
  Future<List<EmployeeLeaveList>> call(String empId) {
    return _repo.getLeaves(empId);
  }
}
