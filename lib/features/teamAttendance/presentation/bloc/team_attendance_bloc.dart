import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../domain/entity/entity.dart';
import '../../domain/entity/send_entity.dart';
import '../../domain/usecase.dart';

part 'team_attendance_event.dart';
part 'team_attendance_state.dart';

class TeamAttendanceBloc extends Bloc<TeamAttendanceEvent, TeamAttendanceState> {

  TeamAttendanceBloc(this._usecase) : super(const TeamAttendanceInitial()) {
    on<TeamAttendanceLoadEvent>(_loadTeamAttendance);
    on<TeamAttendanceChangeEvent>(_changeAttendance);
    on<TeamAttendanceBackEvent>(_onBack);
  }
  final GetTeamAttendanceUsecase _usecase;

  final List<TeamAttendanceLoaded> _biometric = [];

  Future<void> _loadTeamAttendance(
      TeamAttendanceLoadEvent event, Emitter<TeamAttendanceState> emit) async {
    emit(const TeamAttendanceLoading());
    try {
      if (_biometric.isNotEmpty && _biometric.last.empId == event.request.empId) {
        _biometric.removeLast();
      }
      final List<TeamAttendanceEntity> data = await _usecase.call(event.request);
      _biometric.add(
        TeamAttendanceLoaded(
          attendance: data,
          selectedDate: data.first.date,
          startDate: _dateConverter(event.request.startDate),
          endDate: _dateConverter(event.request.endDate),
          stage: _biometric.length + 1,
          reportingTo: event.request.reportingTo,
          empId: event.request.empId,
        ),
      );
      emit(_biometric.last);
    } catch (e) {
      emit(TeamAttendanceError(e.toString()));
    }
  }

  DateTime _dateConverter(String date) {
    final List<String> parts = date.split("/");
    return DateTime(int.parse(parts[2]), int.parse(parts[1]), int.parse(parts[0]));
  }

  Future<void> _changeAttendance(
      TeamAttendanceChangeEvent event, Emitter<TeamAttendanceState> emit) async {
    final TeamAttendanceState currentState = state;
    if (currentState is TeamAttendanceLoaded) {
      emit(currentState.copyWith(selectedDate: event.date));
    }
  }

  Future<void> _onBack(TeamAttendanceBackEvent event, Emitter<TeamAttendanceState> emit) async {
    final TeamAttendanceState currentState = state;
    if (currentState is TeamAttendanceLoaded) {
      _biometric.removeLast();
      emit(_biometric.last);
    }
  }
}
