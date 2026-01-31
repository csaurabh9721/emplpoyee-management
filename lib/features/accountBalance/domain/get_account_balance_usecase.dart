import 'account_balance_entity.dart';
import 'account_balance_repository.dart';

abstract class GetAccountBalanceUsecase {
  Future<List<AccountBalanceEntity>> call();
}

class GetAccountBalanceUsecaseImpl implements GetAccountBalanceUsecase {

  GetAccountBalanceUsecaseImpl(this._accountBalanceRepository);
  final AccountBalanceRepository _accountBalanceRepository;

  @override
  Future<List<AccountBalanceEntity>> call() {
    return _accountBalanceRepository.getAccountBalance();
  }
}
