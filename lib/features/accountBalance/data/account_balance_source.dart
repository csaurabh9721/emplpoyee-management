import 'package:clientone_ess/core/exceptions/api_exceptions.dart';
import 'package:clientone_ess/core/network/apiClients/post_api_base.dart';
import 'package:clientone_ess/core/network/config/network_config.dart';
import 'package:clientone_ess/core/service/sessionManagement/sessions.dart';

import 'account_balance_model.dart';

abstract class AccountBalanceSource {
  Future<AccountBalanceModel> getData();
}

class AccountBalanceSourceImpl extends AccountBalanceSource {
  @override
  Future<AccountBalanceModel> getData() async {
    try {
      final Map<String, String> payload = {
        "employeeid": Sessions.getEmployeeId(),
        "profitcentreid": Sessions.getProfitCentreId(),
        "companyid": Sessions.getCompanyId()
      };
      final Map<String, dynamic> json = await PostApiBase.instance
          .post(url: NetworkConfig.getAccountBalance, body: payload);
      final AccountBalanceModel response = AccountBalanceModel.fromJson(json);
      return response;
    } catch (e) {
      throw AppException(e.toString());
    }
  }
}
