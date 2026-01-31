part of 'leave_ledger_bloc.dart';

@immutable
class LeaveLedgerState extends Equatable {

  const LeaveLedgerState({this.leaveLedger, this.exportStatus});
  final PayslipApiStatus<List<LeaveLedgerEntity>>? leaveLedger;
  final PayslipApiStatus<String>? exportStatus;

  LeaveLedgerState copyWith(
      {PayslipApiStatus<List<LeaveLedgerEntity>>? leaveLedger,
      PayslipApiStatus<String>? exportStatus}) {
    return LeaveLedgerState(
        leaveLedger: leaveLedger ?? this.leaveLedger,
        exportStatus: exportStatus ?? this.exportStatus);
  }

  @override
  List<Object?> get props => [leaveLedger, exportStatus];
}

class PayslipApiStatus<T> {

  const PayslipApiStatus({this.data, required this.status});
  final T? data;
  final APIStatus status;
}
