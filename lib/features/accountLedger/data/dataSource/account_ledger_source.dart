import 'package:clientone_ess/core/exceptions/api_exceptions.dart';
import 'package:clientone_ess/core/service/sessionManagement/sessions.dart';
import '../../../../core/network/apiClients/post_api_base.dart';
import '../models/account_ledger_model.dart';

abstract class AccountLedgerSource {
  Future<AccountLedgerResponseModel> getAccountLedger(
      String fromDate, String toDate, String glId, String glCode);
}

class AccountLedgerSourceImpl implements AccountLedgerSource {
  @override
  Future<AccountLedgerResponseModel> getAccountLedger(
      String fromDate, String toDate, String glId, String glCode) async {
    try {
      final Map<String, dynamic> payload = {
        "fromdate": fromDate,
        "todate": toDate,
        "employeecode": Sessions.getEmployeeCode(),
        "glcode": glCode,
        "glid": glId,
      };
      final Map<String, dynamic> json = await PostApiBase.instance
          .post(url:"", body: payload);
      return AccountLedgerResponseModel.fromJson(json);
    } catch (e) {
      throw AppException(e.toString());
    }
  }
}
