class ContinuousPaidLeaveEntity {

  ContinuousPaidLeaveEntity({
    required String fromDate,
    required String paidType,
    required String startFromFHSH,
    required String leaveTypeId,
    required String numberOfDaysApplied,
  }) {
    _fromDate = fromDate;
    _paidType = paidType;
    _startFromFHSH = startFromFHSH;
    _leaveTypeId = leaveTypeId;
    _numberOfDaysApplied = numberOfDaysApplied;
  }
  late final String _fromDate;
  late final String _paidType;
  late final String _startFromFHSH;
  late final String _leaveTypeId;
  late final String _numberOfDaysApplied;

  String get numberOfDaysApplied => _numberOfDaysApplied;

  String get leaveTypeId => _leaveTypeId;

  String get startFromFHSH => _startFromFHSH;

  String get paidType => _paidType;

  String get fromDate => _fromDate;
}
