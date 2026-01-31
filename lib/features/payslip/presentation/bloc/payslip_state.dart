part of 'payslip_bloc.dart';

@immutable
class PayslipState extends Equatable {

  const PayslipState({this.payslip, this.exportStatus});
  final PayslipApiStatus<PayslipEntity>? payslip;
  final PayslipApiStatus<String>? exportStatus;

  PayslipState copyWith(
      {PayslipApiStatus<PayslipEntity>? payslip, PayslipApiStatus<String>? exportStatus}) {
    return PayslipState(
        payslip: payslip ?? this.payslip, exportStatus: exportStatus ?? this.exportStatus);
  }

  @override
  List<Object?> get props => [payslip, exportStatus];
}

class PayslipApiStatus<T> {

  const PayslipApiStatus({this.data, required this.status});
  final T? data;
  final APIStatus status;
}
