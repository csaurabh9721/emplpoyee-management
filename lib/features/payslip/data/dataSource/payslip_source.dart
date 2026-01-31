import 'dart:typed_data';

import 'package:clientone_ess/core/network/apiClients/post_api_base.dart';
import 'package:clientone_ess/core/network/config/network_config.dart';
import 'package:clientone_ess/core/service/sessionManagement/sessions.dart';
import 'package:clientone_ess/core/utils/string_extensions.dart';
import 'package:clientone_ess/features/payslip/data/model/payslip_model.dart';

import '../../../../core/exceptions/api_exceptions.dart';
import '../../../../core/network/apiClients/byte_post_api_base.dart';

abstract class PayslipSource {
  Future<PayslipResponseMode> getPayslip(String date);

  Future<Uint8List> export(String date);
}

class PayslipSourceImpl implements PayslipSource {
  @override
  Future<PayslipResponseMode> getPayslip(String date) async {
    try {
      final Map<String, String> body = {
        "employeeid": Sessions.getEmployeeId(),
        "yearmonth": date.yyyyMm,
      };
      final Map<String, dynamic> json = await PostApiBase.instance
          .post(url: NetworkConfig.getSalarySlipView, body: body);
      return PayslipResponseMode.fromJson(json);
    } catch (e) {
      throw AppException(e.toString());
    }
  }

  @override
  Future<Uint8List> export(String date) async {
    try {
      final Map<String, String> body = {
        "employeeid": Sessions.getEmployeeId(),
        "payrollareaid": Sessions.getPayrollAreaId(),
        "yearmonth": date.yyyyMm,
      };
      final Uint8List json = await BytePostApiBase.instance
          .post(url: NetworkConfig.getSalarySlipReport, body: body);
      return json;
    } catch (e) {
      throw AppException(e.toString());
    }
  }
}
