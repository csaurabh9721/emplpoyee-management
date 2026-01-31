import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:clientone_ess/core/Enums/enums.dart';
import 'package:meta/meta.dart';

import '../../../domain/useCase/leave_approval_usecase.dart';

part 'leave_approval_event.dart';
part 'leave_approval_state.dart';

class LeaveApprovalBloc extends Bloc<LeaveApprovalEvent, LeaveApprovalState> {
  LeaveApprovalBloc(this._usecase) : super(const LeaveApprovalState()) {
    on<LeaveApprovalApproveEvent>(_onLeaveApprove);
    on<LeaveApprovalRejectEvent>(_onLeaveReject);
  }
  final LeaveApprovalUsecase _usecase;

  Future<void> _onLeaveApprove(
      LeaveApprovalApproveEvent event, Emitter<LeaveApprovalState> emit) async {
    emit(state.copyWith(
        approved: const ApprovalResponse(status: ApiStatus.loading)));
    try {
      final String response = await _usecase.callApproveLeave(
          event.empId, event.leaveId, event.remark);
      emit(state.copyWith(
          approved: ApprovalResponse(
              message: response, status: ApiStatus.completed)));
    } catch (e) {
      emit(state.copyWith(
          approved: ApprovalResponse(
              message: e.toString(), status: ApiStatus.error)));
    }
  }

  Future<void> _onLeaveReject(
      LeaveApprovalRejectEvent event, Emitter<LeaveApprovalState> emit) async {
    emit(state.copyWith(
        reject: const ApprovalResponse(status: ApiStatus.loading)));

    try {
      final String response = await _usecase.callRejectLeave(
          event.empId, event.leaveId, event.remark);
      emit(state.copyWith(
          reject: ApprovalResponse(
              message: response, status: ApiStatus.completed)));
    } catch (e) {
      emit(state.copyWith(
          reject: ApprovalResponse(
              message: e.toString(), status: ApiStatus.error)));
    }
  }
}
