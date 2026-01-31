part of 'get_emp_list_cubit.dart';

@immutable
abstract class GetEmpListState {
  const GetEmpListState();

}

final class GetEmpListLoadingState extends GetEmpListState {}

final class GetEmpListSuccessState extends GetEmpListState {

  const GetEmpListSuccessState(this.employees);
  final List<EmployeeListEntity> employees;

}

final class GetEmpListErrorState extends GetEmpListState {

  const GetEmpListErrorState(this.error);
  final String error;

}
