import 'package:clientone_ess/features/accountBalance/domain/account_balance_entity.dart';

abstract class AccountBalanceRepository {
  Future<List<AccountBalanceEntity>> getAccountBalance();
}
