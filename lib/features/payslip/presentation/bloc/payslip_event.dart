part of 'payslip_bloc.dart';

@immutable
abstract class PayslipEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

final class ViewPaySlipEvent extends PayslipEvent {

  ViewPaySlipEvent(this.date);
  final String date;

  @override
  List<Object?> get props => [date];
}

final class DownLoadPaySlipEvent extends PayslipEvent {

  DownLoadPaySlipEvent(this.date);
  final String date;

  @override
  List<Object?> get props => [date];
}
