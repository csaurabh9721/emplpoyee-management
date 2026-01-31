class LeaveBalanceEntity {

  LeaveBalanceEntity(
      {required String openingDate,
      required String leaveTypeCode,
      required String leaveName,
      required String openingBalance,
      required String currentAccumulation,
      required String leaveCredited,
      required String availed,
      required String pendingForApproval,
      required String balance}) {
    _openingDate = openingDate;
    _leaveTypeCode = leaveTypeCode;
    _leaveName = leaveName;
    _openingBalance = openingBalance;
    _currentAccumulation = currentAccumulation;
    _leaveCredited = leaveCredited;
    _availed = availed;
    _pendingForApproval = pendingForApproval;
    _balance = balance;
  }
  late final String _openingDate;
  late final String _leaveTypeCode;
  late final String _leaveName;
  late final String _openingBalance;
  late final String _currentAccumulation;
  late final String _leaveCredited;
  late final String _availed;
  late final String _pendingForApproval;
  late final String _balance;

  String get balance {
    try {
      return double.parse(_balance).toStringAsFixed(1);
    } catch (e) {
      return _balance;
    }
  }

  String get pendingForApproval {
    try {
      return double.parse(_pendingForApproval).toStringAsFixed(1);
    } catch (e) {
      return _pendingForApproval;
    }
  }

  String get availed {
    try {
      return double.parse(_availed).toStringAsFixed(1);
    } catch (e) {
      return _availed;
    }
  }

  String get leaveCredited {
    try {
      return double.parse(_leaveCredited).toStringAsFixed(1);
    } catch (e) {
      return _leaveCredited;
    }
  }

  String get currentAccumulation {
    try {
      return double.parse(_currentAccumulation).toStringAsFixed(1);
    } catch (e) {
      return _currentAccumulation;
    }
  }

  String get openingBalance {
    try {
      return double.parse(_openingBalance).toStringAsFixed(1);
    } catch (e) {
      return _openingBalance;
    }
  }

  String get leaveName => _leaveName;

  String get leaveTypeCode => _leaveTypeCode;

  String get openingDate => _openingDate;
}
