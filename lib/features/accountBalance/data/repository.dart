import 'package:clientone_ess/features/accountBalance/data/account_balance_source.dart';
import 'package:clientone_ess/features/accountBalance/domain/account_balance_entity.dart';

import '../../../core/exceptions/api_exceptions.dart';
import '../domain/account_balance_repository.dart';
import 'account_balance_model.dart';

class AccountBalanceRepositoryImpl implements AccountBalanceRepository {
  AccountBalanceRepositoryImpl(this._remoteAccountBalanceSource);
  final AccountBalanceSource _remoteAccountBalanceSource;

  @override
  Future<List<AccountBalanceEntity>> getAccountBalance() async {
    final AccountBalanceModel response =
        await _remoteAccountBalanceSource.getData();
    if (response.statusCode != 200) {
      throw AppException(response.message);
    }
    if (response.data == null) {
      throw AppException(response.message);
    }
    return response.toEntity();
  }
}
