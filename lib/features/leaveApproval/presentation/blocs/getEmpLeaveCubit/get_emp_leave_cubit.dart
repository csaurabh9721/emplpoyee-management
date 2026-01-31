import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../../domain/entity/employee_leave_list.dart';
import '../../../domain/useCase/get_emp_leave_usecase.dart';

part 'get_emp_leave_state.dart';

class GetEmpLeaveCubit extends Cubit<GetEmpLeaveState> {

  GetEmpLeaveCubit(this._useCase) : super(GetEmpLeaveInitialState());
  final GetEmpLeaveUsecase _useCase;

  Future<void> getLeaves(String impId) async {
    emit(GetEmpLeaveLoadingState());
    try {
      final List<EmployeeLeaveList> response = await _useCase.call(impId);
      emit(GetEmpLeaveSuccessState(response));
    } catch (e) {
      emit(GetEmpLeaveErrorState(e.toString()));
    }
  }
  Future<void> reset() async {
    emit(GetEmpLeaveInitialState());
  }
}
