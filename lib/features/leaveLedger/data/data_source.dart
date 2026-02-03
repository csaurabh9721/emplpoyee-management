import 'dart:typed_data';
import 'package:clientone_ess/core/exceptions/api_exceptions.dart';
import 'package:clientone_ess/core/network/apiClients/post_api_base.dart';
import 'package:clientone_ess/core/service/sessionManagement/sessions.dart';
import 'package:clientone_ess/shared/constants/app_constant.dart';
import '../../../core/network/apiClients/byte_post_api_base.dart';
import 'model.dart';

abstract class LeaveLedgerSource {
  Future<ViewLeaveLedgerModel> fetchLeaveLedger(
      String startDate, String endDate);

  Future<Uint8List> exportLeaveLedger(String startDate, String endDate);
}

class LeaveLedgerSourceImpl implements LeaveLedgerSource {
  @override
  Future<ViewLeaveLedgerModel> fetchLeaveLedger(
      String startDate, String endDate) async {
    try {
      final Map<String, String> payload = {
        "fromdate": startDate,
        "todate": endDate
      };
      final Map<String, dynamic> json = await PostApiBase.instance
          .post(url: "", body: payload);
      return ViewLeaveLedgerModel.fromJson(json);
    } catch (e) {
      throw AppException(e.toString());
    }
  }

  @override
  Future<Uint8List> exportLeaveLedger(String startDate, String endDate) async {
    try {
      final Map<String, String> payload = {
        "employeecode": Sessions.getEmployeeCode(),
        "employeename": AppConstant.employeeName,
        "fromdate": startDate,
        "todate": endDate,
      };
      final Uint8List json = await BytePostApiBase.instance
          .post(url: "", body: payload);
      return json;
    } catch (e) {
      throw AppException(e.toString());
    }
  }
}
