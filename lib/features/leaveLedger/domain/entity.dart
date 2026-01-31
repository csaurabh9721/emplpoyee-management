class LeaveLedgerEntity {

  LeaveLedgerEntity({
    required this.leaveShortName,
    required this.leaveDescription,
    required this.total,
    required this.leaveEndDate,
    required this.leaveStartDate,
  });
  final String leaveShortName;
  final String leaveDescription;
  final double total;
  final String leaveEndDate;
  final String leaveStartDate;
}
