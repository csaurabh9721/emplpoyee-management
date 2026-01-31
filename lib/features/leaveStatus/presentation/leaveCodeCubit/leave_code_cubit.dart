import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../domain/entity/leave_code_entity.dart';
import '../../domain/usecases/get_leave_code_usecase.dart';

part 'leave_code_state.dart';

class LeaveCodeCubit extends Cubit<LeaveCodeState> {

  LeaveCodeCubit(this._getLeaveCodeUsecase) : super(const LeaveCodeInitial());
  final GetLeaveCodeUsecase _getLeaveCodeUsecase;

  Future<void> getLeaveCodes() async {
    emit(const LeaveCodeLoading());
    try {
      final leaveCodes = await _getLeaveCodeUsecase();
      emit(LeaveCodeLoaded(leaveCodes));
    } catch (e) {
      emit(LeaveCodeError(e.toString()));
    }
  }
}
