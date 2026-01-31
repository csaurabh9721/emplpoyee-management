import 'package:clientone_ess/features/accountLedger/domain/repository/account_ledger_repository.dart';

import '../entity/account_ledger_entity.dart';

abstract class GetAccountLedgerUsecase {
  Future<AccountLedgerEntity> call(
      String fromDate, String toDate, String glId, String glCode);
}

class GetAccountLedgerUsecaseImpl implements GetAccountLedgerUsecase {
  GetAccountLedgerUsecaseImpl(this._repository);
  final AccountLedgerRepository _repository;
  @override
  Future<AccountLedgerEntity> call(
      String fromDate, String toDate, String glId, String glCode) {
    return _repository.getAccountLedger(fromDate, toDate, glId, glCode);
  }
}
