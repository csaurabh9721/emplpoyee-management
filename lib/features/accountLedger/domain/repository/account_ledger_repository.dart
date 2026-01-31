import '../entity/account_ledger_entity.dart';

abstract class AccountLedgerRepository {
  Future<AccountLedgerEntity> getAccountLedger(String fromDate, String toDate, String glId,String glCode);
}
