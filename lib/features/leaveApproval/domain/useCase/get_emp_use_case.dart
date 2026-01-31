import '../entity/employee_list_entity.dart';
import '../repo/get_emp_list_repo.dart';

abstract class GetEmpUseCase {
  Future<List<EmployeeListEntity>> call();
}

class GetEmpUseCaseImpl implements GetEmpUseCase {

  GetEmpUseCaseImpl(this._repo);
  final GetEmpListRepo _repo;

  @override
  Future<List<EmployeeListEntity>> call() {
    return _repo.getEmployeeList();
  }
}
