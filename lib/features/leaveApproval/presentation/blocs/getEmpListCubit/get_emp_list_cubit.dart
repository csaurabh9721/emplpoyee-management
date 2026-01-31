import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../../domain/entity/employee_list_entity.dart';
import '../../../domain/useCase/get_emp_use_case.dart';

part 'get_emp_list_state.dart';

class GetEmpListCubit extends Cubit<GetEmpListState> {

  GetEmpListCubit(this._useCase) : super(GetEmpListLoadingState());
  final GetEmpUseCase _useCase;

  Future<void> getEmpList() async {
    emit(GetEmpListLoadingState());
    try {
      final List<EmployeeListEntity> response = await _useCase.call();
      emit(GetEmpListSuccessState(response));
    } catch (e) {
      emit(GetEmpListErrorState(e.toString()));
    }
  }
}
