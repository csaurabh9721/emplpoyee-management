part of 'attendance_bloc.dart';

@immutable
abstract class AttendanceState extends Equatable {
  const AttendanceState();

  @override
  List<Object?> get props => [];
}

final class AttendanceInitial extends AttendanceState {
  const AttendanceInitial();
}

final class AttendanceLoading extends AttendanceState {
  const AttendanceLoading();
}

final class AttendanceLoaded extends AttendanceState {

  const AttendanceLoaded({required this.entity, required this.isSummary});
  final AttendanceEntity entity;
  final bool isSummary;

  AttendanceLoaded copyWith({AttendanceEntity? entity, bool? isSummary}) {
    return AttendanceLoaded(
      entity: entity ?? this.entity,
      isSummary: isSummary ?? this.isSummary,
    );
  }

  @override
  List<Object?> get props => [entity, isSummary];
}

final class AttendanceError extends AttendanceState {

  const AttendanceError(this._error);
  final String _error;

  String get error => "Error: $_error";
}
