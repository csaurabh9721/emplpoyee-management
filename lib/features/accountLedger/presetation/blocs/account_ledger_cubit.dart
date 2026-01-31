import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entity/account_ledger_entity.dart';
import '../../domain/useCases/get_account_ledger_usecase.dart';
import 'account_ledger_state.dart';

class AccountLedgerCubit extends Cubit<AccountLedgerState> {

  AccountLedgerCubit(this._usecase) : super(const AccountLedgerInitial());
  final GetAccountLedgerUsecase _usecase;

  void getAccountLedger(String fromDate, String toDate, String glId, String glCode) async {
    emit(const AccountLedgerLoading());
    try {
      final AccountLedgerEntity data = await _usecase.call(fromDate, toDate, glId, glCode);
      emit(AccountLedgerLoaded(data));
    } catch (e) {
      emit(AccountLedgerError(e.toString()));
    }
  }
}
