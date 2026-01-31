import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:clientone_ess/features/leaveHistory/domain/entity.dart';
import 'package:clientone_ess/features/leaveHistory/domain/use_case.dart';
import 'package:meta/meta.dart';

part 'leave_history_event.dart';
part 'leave_history_state.dart';

class LeaveHistoryBloc extends Bloc<LeaveHistoryEvent, LeaveHistoryState> {
  LeaveHistoryBloc(this._useCase) : super(LeaveHistoryInitial()) {
    on<LoadLeaveHistoryEvent>(_loadLeaveHistory);
  }
  final GetLeaveHistoryUseCase _useCase;

  Future<void> _loadLeaveHistory(
      LoadLeaveHistoryEvent event, Emitter<LeaveHistoryState> emit) async {
    emit(LeaveHistoryLoading());
    try {
      final List<LeaveHistoryEntity> leaveHistory =
          await _useCase.call(event.startDate, event.endDate);
      emit(LeaveHistoryLoaded(leaveHistory));
    } catch (e) {
      emit(LeaveHistoryError(e.toString()));
    }
  }
}
