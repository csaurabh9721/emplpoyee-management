import 'package:clientone_ess/features/accountLedger/data/dataSource/account_ledger_source.dart';
import 'package:clientone_ess/features/accountLedger/domain/entity/account_ledger_entity.dart';

import '../../../../core/exceptions/api_exceptions.dart';
import '../../domain/repository/account_ledger_repository.dart';
import '../models/account_ledger_model.dart';

class AccountLedgerRepositoryImpl implements AccountLedgerRepository {
  AccountLedgerRepositoryImpl(this._remoteAccountLedgerSource);
  final AccountLedgerSource _remoteAccountLedgerSource;

  @override
  Future<AccountLedgerEntity> getAccountLedger(
      String fromDate, String toDate, String glId, String glCode) async {
    final AccountLedgerResponseModel response = await _remoteAccountLedgerSource
        .getAccountLedger(fromDate, toDate, glId, glCode);
    if (response.statusCode != 200) {
      throw AppException(response.message);
    }
    if (response.data == null) {
      throw AppException("No data found");
    }
    return response.toEntity();
  }
}
