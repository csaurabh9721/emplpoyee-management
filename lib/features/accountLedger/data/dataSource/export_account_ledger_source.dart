import 'dart:typed_data';

import '../../../../core/exceptions/api_exceptions.dart';
import '../../../../core/network/apiClients/byte_post_api_base.dart';
import '../../../../core/network/config/network_config.dart';
import '../../../../core/service/sessionManagement/sessions.dart';

class ExportAccountLedgerSource {
  Future<Uint8List> export(String startDate, String endDate, String gl) async {
    try {
      final Map<String, String> body = {
        "fromdate": startDate,
        "todate": endDate,
        "profitcentreid": Sessions.getProfitCentreId(),
        "companyid": Sessions.getCompanyId(),
        "glid": gl,
        "employeecode": Sessions.getEmployeeCode(),
      };
      final Uint8List json = await BytePostApiBase.instance
          .post(url: NetworkConfig.downloadAccountLedgerReport, body: body);

      return json;
    } catch (e) {
      throw AppException(e.toString());
    }
  }
}
