import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../domain/entity.dart';
import '../../domain/usecase.dart' show GetLeaveBalanceLeaveUsecase;

part 'leave_balance_state.dart';

class LeaveBalanceCubit extends Cubit<LeaveBalanceState> {

  LeaveBalanceCubit(this._usecase) : super(const LeaveBalanceInitial());
  final GetLeaveBalanceLeaveUsecase _usecase;

  Future<void> getLeaveBalance(String date) async {
    emit(const LeaveBalanceLoading());
    try {
      final List<LeaveBalanceEntity> leaveBalanceEntity = await _usecase.call(date);
      emit(LeaveBalanceLoaded(leaveBalanceEntity));
    } catch (e) {
      emit(LeaveBalanceError(e.toString()));
    }
  }
}
