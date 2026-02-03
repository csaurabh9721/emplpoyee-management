class DashboardResponseEntity {
  final PunchInPunchOutEntity? punchTime;
  final List<PunchInPunchOutEntity> lastPunches;

  const DashboardResponseEntity({
    required this.punchTime,
    required this.lastPunches,
  });

  @override
  String toString() {
    return 'DashboardResponseEntity{punchTime: $punchTime, lastPunches: $lastPunches}';
  }
}

final class PunchInPunchOutEntity {
  final String? punchInTime;
  final String? punchOutTime;

  const PunchInPunchOutEntity({
    required this.punchInTime,
    required this.punchOutTime,
  });

  @override
  String toString() {
    return 'PunchInPunchOutEntity{punchInTime: $punchInTime, punchOutTime: $punchOutTime}';
  }
}
