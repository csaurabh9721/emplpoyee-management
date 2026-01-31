import 'dart:typed_data';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../../../core/Enums/enums.dart';
import '../../../../core/exceptions/api_exceptions.dart';
import '../../../../core/service/save_file.dart';
import '../../domain/entity.dart';
import '../../domain/usecase.dart';

part 'leave_ledger_event.dart';
part 'leave_ledger_state.dart';

class LeaveLedgerBloc extends Bloc<LeaveLedgerEvent, LeaveLedgerState> {

  LeaveLedgerBloc(this._usecase) : super(const LeaveLedgerState()) {
    on<LeaveLedgerFetchEvent>(_fetchLeaveLedger);
    on<LeaveLedgerExportEvent>(_exportLeaveLedger);
  }
  final LeaveLedgerUsecase _usecase;

  void _fetchLeaveLedger(LeaveLedgerFetchEvent event, Emitter<LeaveLedgerState> emit) async {
    try {
      emit(state.copyWith(leaveLedger: const PayslipApiStatus(status: APIStatus.loading)));
      final List<LeaveLedgerEntity> response =
          await _usecase.getLeaveLedger(event.startDate, event.endDate);
      emit(
          state.copyWith(leaveLedger: PayslipApiStatus(data: response, status: APIStatus.success)));
    } catch (e) {
      emit(state.copyWith(leaveLedger: const PayslipApiStatus(status: APIStatus.error)));
    }
  }

  void _exportLeaveLedger(LeaveLedgerExportEvent event, Emitter<LeaveLedgerState> emit) async {
    try {
      emit(state.copyWith(exportStatus: const PayslipApiStatus(status: APIStatus.loading)));
      final Uint8List response = await _usecase.exportLeaveLedger(event.startDate, event.endDate);
      final String savedFile = await _downloadPaySlip(response, event.startDate);
      emit(state.copyWith(
          exportStatus: PayslipApiStatus(data: savedFile, status: APIStatus.success)));
    } catch (e) {
      emit(state.copyWith(
          exportStatus: PayslipApiStatus(status: APIStatus.error, data: e.toString())));
    }
  }

  Future<String> _downloadPaySlip(Uint8List payslip, String date) async {
    try {
      return await FileDownloader().saveFile(payslip, "leave_ledger_$date.pdf");
    } catch (e) {
      throw AppException(e.toString());
    }
  }
}
