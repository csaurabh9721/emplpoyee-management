import 'dart:typed_data';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:clientone_ess/core/service/save_file.dart';

import '../../../../core/exceptions/api_exceptions.dart';
import '../../data/dataSource/export_account_ledger_source.dart';
import 'account_ledger_state.dart';

class ExportLedgerCubit extends Cubit<AccountLedgerState> {
  ExportLedgerCubit() : super(const AccountLedgerInitial());

  void ledgerExport(String startDate, String endDate, String gl) async {
    emit(const AccountLedgerLoading());
    try {
      final Uint8List payslip =
          await ExportAccountLedgerSource().export(startDate, endDate, gl);
      final String savedFile = await _downloadPaySlip(payslip, startDate);
      emit(AccountLedgerExport("File saved : $savedFile"));
    } catch (e) {
      emit(AccountLedgerError(e.toString()));
    }
  }

  Future<String> _downloadPaySlip(Uint8List payslip, String date) async {
    try {
      return await FileDownloader()
          .saveFile(payslip, "account_ledger_$date.pdf");
    } catch (e) {
      throw AppException(e.toString());
    }
  }
}
