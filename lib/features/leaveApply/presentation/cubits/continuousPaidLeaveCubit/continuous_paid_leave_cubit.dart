import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../../domain/entities/continuous_paid_leave.dart';
import '../../../domain/usecases/continuous_paid_leave_usecase.dart';

part 'continuous_paid_leave_state.dart';

class ContinuousPaidLeaveCubit extends Cubit<ContinuousPaidLeaveState> {

  ContinuousPaidLeaveCubit(this._usecase) : super(ContinuousPaidLeaveInitial());
  final ContinuousPaidLeaveUsecase _usecase;

  void checkContinuousPaidLeave(ContinuousPaidLeaveEntity postData) async {
    emit(const ContinuousPaidLeaveLoading());
    try {
      final Map<int, String> data = await _usecase.continuousPaidLeave(postData);
      emit(ContinuousPaidLeaveSuccess(continuousPaidLeave: data));
    } catch (e) {
      emit(ContinuousPaidLeaveError(e.toString()));
    }
  }
}
