part of 'get_emp_leave_cubit.dart';

@immutable
abstract class GetEmpLeaveState  {
  const GetEmpLeaveState();

}

final class GetEmpLeaveInitialState extends GetEmpLeaveState {}

final class GetEmpLeaveLoadingState extends GetEmpLeaveState {}

final class GetEmpLeaveSuccessState extends GetEmpLeaveState {

  const GetEmpLeaveSuccessState(this.leaves);
  final List<EmployeeLeaveList> leaves;

}

final class GetEmpLeaveErrorState extends GetEmpLeaveState {
  const GetEmpLeaveErrorState(this.error);
  final String error;
}
