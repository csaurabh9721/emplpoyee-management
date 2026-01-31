part of 'team_attendance_bloc.dart';

@immutable
abstract class TeamAttendanceEvent {
  const TeamAttendanceEvent();
}

final class TeamAttendanceLoadEvent extends TeamAttendanceEvent {

  const TeamAttendanceLoadEvent(this.request);
  final TeamAttendanceRequest request;

}

final class TeamAttendanceChangeEvent extends TeamAttendanceEvent {

  const TeamAttendanceChangeEvent(this.date);
  final String date;

}

final class TeamAttendanceBackEvent extends TeamAttendanceEvent {

}