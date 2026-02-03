import 'dart:typed_data';
import 'package:clientone_ess/core/utils/string_extensions.dart';
import 'package:clientone_ess/features/payslip/data/model/payslip_model.dart';
import '../../../../core/exceptions/api_exceptions.dart';
import '../../../../core/network/apiClients/byte_post_api_base.dart';
import '../../../../core/network/apiClients/get_api_base.dart';

abstract class PayslipSource {
  Future<PayslipResponseMode> getPayslip(String date);

  Future<Uint8List> export(String date);
}

class PayslipSourceImpl implements PayslipSource {
  @override
  Future<PayslipResponseMode> getPayslip(String date) async {
    try {
      final Map<String, dynamic> json = await GetApiBase.instance
          .getApi(url: date.yyyyMm,);
      return PayslipResponseMode.fromJson(json);
    } catch (e) {
      throw AppException(e.toString());
    }
  }

  @override
  Future<Uint8List> export(String date) async {
    try {
      final Map<String, String> body = {
        "yearmonth": date.yyyyMm,
      };
      final Uint8List json = await BytePostApiBase.instance
          .post(url: "", body: body);
      return json;
    } catch (e) {
      throw AppException(e.toString());
    }
  }
}
