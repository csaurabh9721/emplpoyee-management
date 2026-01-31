import 'package:clientone_ess/core/network/apiClients/post_api_base.dart';
import 'package:clientone_ess/core/network/config/network_config.dart';
import 'package:clientone_ess/core/service/sessionManagement/sessions.dart';
import 'package:clientone_ess/shared/constants/app_constant.dart';

import '../../../core/exceptions/api_exceptions.dart';
import 'model.dart';

abstract class AttendanceSource {
  Future<GetSelfAttendanceResponse> getData(String startDate, String endDate);
}

class AttendanceSourceImpl implements AttendanceSource {
  @override
  Future<GetSelfAttendanceResponse> getData(
      String startDate, String endDate) async {
    try {
      final Map<String, dynamic> body = {
        "employeelist": [
          {
            "employeeid": Sessions.getEmployeeId(),
            "fromdate": startDate,
            "todate": endDate,
            "employeecode": Sessions.getEmployeeCode(),
            "employeename": AppConstant.employeeName,
            "placeofpostingid": Sessions.getPlaceOfPostingId(),
            "payrollareaid": Sessions.getPayrollAreaId(),
            "userid": Sessions.getUserId(),
          }
        ],
        "payrollareaid": Sessions.getPayrollAreaId(),
        "fromdate": startDate,
        "todate": endDate,
        "userid": Sessions.getUserId(),
      };
      final Map<String, dynamic> json = await PostApiBase.instance
          .post(url: NetworkConfig.getSelfAttendance, body: body);
      return GetSelfAttendanceResponse.fromJson(json);
    } catch (e) {
      throw AppException(e.toString());
    }
  }
}
