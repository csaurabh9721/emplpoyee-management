part of 'leave_ledger_bloc.dart';

@immutable
abstract class LeaveLedgerEvent extends Equatable {
  const LeaveLedgerEvent();

  @override
  List<Object> get props => [];
}

final class LeaveLedgerFetchEvent extends LeaveLedgerEvent {

  const LeaveLedgerFetchEvent(this.startDate, this.endDate);
  final String startDate;
  final String endDate;

  @override
  List<Object> get props => [startDate, endDate];
}

final class LeaveLedgerExportEvent extends LeaveLedgerEvent {

  const LeaveLedgerExportEvent(this.startDate, this.endDate);
  final String startDate;
  final String endDate;

  @override
  List<Object> get props => [startDate, endDate];
}
