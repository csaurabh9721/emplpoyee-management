import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:clientone_ess/features/leaveStatus/domain/usecases/get_leave_status_usecase.dart';
import 'package:meta/meta.dart';

import '../../../../core/Enums/enums.dart';
import '../../domain/entity/leave_status_entity.dart';

part 'leave_status_event.dart';
part 'leave_status_state.dart';

class LeaveStatusBloc extends Bloc<LeaveStatusEvent, LeaveStatusState> {
  LeaveStatusBloc(this._usecase, this._viewOnlyPending)
      : super(const LeaveStatusInitial()) {
    on<LeaveStatusLoadedEvent>(_loadLeaveStatus);
    on<LeaveStatusViewToggleEvent>(_viewLeaveToggle);
    on<LeaveStatusWithdrawEvent>(_leaveWithdraw);
  }
  final GetLeaveStatusUsecase _usecase;
  final bool _viewOnlyPending;
  bool get viewOnlyPending => _viewOnlyPending;

  Future<void> _loadLeaveStatus(
      LeaveStatusLoadedEvent event, Emitter<LeaveStatusState> emit) async {
    emit(const LeaveStatusLoading());
    try {
      List<LeaveStatusEntity> leaveStatus = await _usecase.callLeaveStatus(
        fromDate: event.startDate,
        toDate: event.endDate,
        leaveType: event.leaveType,
        leaveStatus: event.leaveStatus == "All"
            ? event.leaveStatus
            : event.leaveStatus[0],
      );
      leaveStatus =
          _viewOnlyPending ? _pendingLeaveStatus(leaveStatus) : leaveStatus;
      emit(LeaveStatusLoaded(leaveStatus: leaveStatus));
    } catch (e) {
      emit(LeaveStatusError(e.toString()));
    }
  }

  List<LeaveStatusEntity> _pendingLeaveStatus(List<LeaveStatusEntity> data) {
    final List<LeaveStatusEntity> pendingLeaveStatus = [];
    for (LeaveStatusEntity leaveStatus in data) {
      if (leaveStatus.status == "Pending") {
        pendingLeaveStatus.add(leaveStatus);
      }
    }
    return pendingLeaveStatus;
  }

  Future<void> _viewLeaveToggle(
      LeaveStatusViewToggleEvent event, Emitter<LeaveStatusState> emit) async {
    final LeaveStatusState currentState = state;
    if (currentState is LeaveStatusLoaded) {
      emit(currentState.copyWith(
        selectedLeave: event.chosenLeave,
      ));
    }
  }

  Future<void> _leaveWithdraw(
      LeaveStatusWithdrawEvent event, Emitter<LeaveStatusState> emit) async {
    final LeaveStatusState currentState = state;
    if (currentState is LeaveStatusLoaded) {
      emit(currentState.copyWith(
        selectedLeave: currentState.selectedLeave,
        withdrawStatus: APIStatus.loading,
      ));
      try {
        final bool response = await _usecase.callLeaveWithdraw(
            event.leaveApplicationNo, event.withdrawReason);
        if (response) {
          emit(currentState.copyWith(
            selectedLeave: currentState.selectedLeave,
            withdrawStatus: APIStatus.success,
          ));
        } else {
          throw Exception();
        }
      } catch (e) {
        emit(currentState.copyWith(
          selectedLeave: currentState.selectedLeave,
          withdrawStatus: APIStatus.error,
        ));
      }
    }
  }
}
