import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:clientone_ess/core/Enums/enums.dart';
import 'package:clientone_ess/features/payslip/domain/entity/payslip_entity.dart';

import '../../../../core/exceptions/api_exceptions.dart';
import '../../../../core/service/save_file.dart';
import '../../domain/usecases/get_payslip_usecase.dart';

part 'payslip_event.dart';
part 'payslip_state.dart';

class PayslipBloc extends Bloc<PayslipEvent, PayslipState> {
  PayslipBloc(this._useCase) : super(const PayslipState()) {
    on<ViewPaySlipEvent>(_viewPaySlip);
    on<DownLoadPaySlipEvent>(_exportToPdf);
  }
  final GetPayslipUseCase _useCase;

  void _viewPaySlip(ViewPaySlipEvent event, Emitter<PayslipState> emit) async {
    try {
      emit(state.copyWith(
          payslip: const PayslipApiStatus(status: APIStatus.loading)));
      final PayslipEntity payslip = await _useCase.callGetPayslip(event.date);
      emit(state.copyWith(
          payslip: PayslipApiStatus(data: payslip, status: APIStatus.success)));
    } catch (e) {
      emit(state.copyWith(
          payslip: const PayslipApiStatus(status: APIStatus.error)));
    }
  }

  void _exportToPdf(
      DownLoadPaySlipEvent event, Emitter<PayslipState> emit) async {
    try {
      emit(state.copyWith(
          exportStatus: const PayslipApiStatus(status: APIStatus.loading)));
      final Uint8List payslip = await _useCase.callExportPaySlip(event.date);
      final String savedFile = await _downloadPaySlip(payslip, event.date);
      emit(state.copyWith(
          exportStatus:
              PayslipApiStatus(data: savedFile, status: APIStatus.success)));
    } catch (e) {
      emit(state.copyWith(
          exportStatus:
              PayslipApiStatus(status: APIStatus.error, data: e.toString())));
    }
  }

  Future<String> _downloadPaySlip(Uint8List payslip, String date) async {
    try {
      return await FileDownloader().saveFile(payslip, "payslip_$date.pdf");
    } catch (e) {
      throw AppException(e.toString());
    }
  }
}
