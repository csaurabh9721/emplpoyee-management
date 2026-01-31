part of 'team_attendance_bloc.dart';

@immutable
abstract class TeamAttendanceState {
  const TeamAttendanceState();
}

final class TeamAttendanceInitial extends TeamAttendanceState {
  const TeamAttendanceInitial();
}

final class TeamAttendanceLoading extends TeamAttendanceState {
  const TeamAttendanceLoading();
}

final class TeamAttendanceLoaded extends TeamAttendanceState {

  const TeamAttendanceLoaded({
    required this.attendance,
    required this.selectedDate,
    required this.startDate,
    required this.endDate,
    required this.stage,
    required this.reportingTo,
    required this.empId,
  });
  final List<TeamAttendanceEntity> attendance;
  final String selectedDate;
  final DateTime startDate;
  final DateTime endDate;
  final int stage;
  final String reportingTo;
  final String empId;

  TeamAttendanceLoaded copyWith({
    List<TeamAttendanceEntity>? attendance,
    String? selectedDate,
    DateTime? startDate,
    DateTime? endDate,
    int? stage,
    String? reportingTo,
    String? empId,
  }) {
    return TeamAttendanceLoaded(
      attendance: attendance ?? this.attendance,
      selectedDate: selectedDate ?? this.selectedDate,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      stage: stage ?? this.stage,
      reportingTo: reportingTo ?? this.reportingTo,
      empId: empId ?? this.empId,
    );
  }

  List<DateWiseBiometric> get getAttendanceForDate {
    return attendance.firstWhere((element) => element.date == selectedDate).biometrics;
  }
}

final class TeamAttendanceError extends TeamAttendanceState {

  const TeamAttendanceError(this.message);
  final String message;
}
