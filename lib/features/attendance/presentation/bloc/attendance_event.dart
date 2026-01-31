part of 'attendance_bloc.dart';

@immutable
abstract class AttendanceEvent extends Equatable {
  const AttendanceEvent();

  @override
  List<Object?> get props => [];
}

final class AttendanceViewSummaryEvent extends AttendanceEvent {

  const AttendanceViewSummaryEvent(this.startDate, this.endDate);
  final String startDate;
  final String endDate;

  @override
  List<Object?> get props => [startDate, endDate];
}

final class AttendanceViewDetailEvent extends AttendanceEvent {

  const AttendanceViewDetailEvent(this.startDate, this.endDate);
  final String startDate;
  final String endDate;

  @override
  List<Object?> get props => [startDate, endDate];
}
