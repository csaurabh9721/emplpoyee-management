import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../domain/attendance_entity.dart';
import '../../domain/get_attendance_usecase.dart';

part 'attendance_event.dart';
part 'attendance_state.dart';

class AttendanceBloc extends Bloc<AttendanceEvent, AttendanceState> {

  AttendanceBloc(this._usecase) : super(const AttendanceInitial()) {
    on<AttendanceViewDetailEvent>(_viewDetail);
    on<AttendanceViewSummaryEvent>(_viewSummary);
  }
  final GetAttendanceUsecase _usecase;

   String _startDate = "";
   String _endDate = "";

  Future<void> _viewDetail(AttendanceViewDetailEvent event, Emitter<AttendanceState> emit) async {
    final AttendanceState currentState = state;
    if (currentState is AttendanceLoaded &&
        event.startDate == _startDate &&
        event.endDate == _endDate) {
      emit(currentState.copyWith(isSummary: false));
    } else {
      emit(const AttendanceLoading());
      try {
        final AttendanceEntity response = await _usecase.call(event.startDate, event.endDate);
        emit(AttendanceLoaded(entity: response, isSummary: false));
        _startDate = event.startDate;
        _endDate = event.endDate;
      } catch (e) {
        emit(AttendanceError(e.toString()));
      }
    }
  }

  Future<void> _viewSummary(AttendanceViewSummaryEvent event, Emitter<AttendanceState> emit) async {
    final AttendanceState currentState = state;
    if (currentState is AttendanceLoaded &&
        event.startDate == _startDate &&
        event.endDate == _endDate) {
      emit(currentState.copyWith(isSummary: true));
    } else {
      emit(const AttendanceLoading());
      try {
        final AttendanceEntity response = await _usecase.call(event.startDate, event.endDate);
        emit(AttendanceLoaded(entity: response, isSummary: true));
        _startDate = event.startDate;
        _endDate = event.endDate;
      } catch (e) {
        emit(AttendanceError(e.toString()));
      }
    }
  }
}
