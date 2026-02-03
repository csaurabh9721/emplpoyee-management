import 'package:clientone_ess/core/exceptions/api_exceptions.dart';
import 'package:clientone_ess/core/network/apiClients/get_api_base.dart';
import 'account_balance_model.dart';

abstract class AccountBalanceSource {
  Future<AccountBalanceModel> getData();
}

class AccountBalanceSourceImpl extends AccountBalanceSource {
  @override
  Future<AccountBalanceModel> getData() async {
    try {
      final Map<String, dynamic> json = await GetApiBase.instance
          .getApi(url: "", );
      final AccountBalanceModel response = AccountBalanceModel.fromJson(json);
      return response;
    } catch (e) {
      throw AppException(e.toString());
    }
  }
}
