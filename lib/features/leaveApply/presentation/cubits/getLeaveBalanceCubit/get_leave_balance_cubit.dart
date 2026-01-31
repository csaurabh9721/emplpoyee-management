import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../../domain/entities/leave_balance_entity.dart';
import '../../../domain/usecases/get_leave_balance_usecase.dart';

part 'get_leave_balance_state.dart';

class GetLeaveBalanceCubit extends Cubit<GetLeaveBalanceState> {

  GetLeaveBalanceCubit(this._usecase) : super(const GetLeaveBalanceInitial());
  final GetLeaveBalanceUsecase _usecase;

  void loadLeaveBalance(String date) async {
    emit(const GetLeaveBalanceLoading());
    try {
      final ApplyLeaveBalanceEntity data = await _usecase.getLeaveBalance(date);
      emit(GetLeaveBalanceSuccess(
        leaveBalanceEntity: data,
      ));
    } catch (e) {
      emit(GetLeaveBalanceError(e.toString()));
    }
  }
}
