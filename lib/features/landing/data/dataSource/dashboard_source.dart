import 'package:clientone_ess/features/landing/data/models/dashboard_response_model.dart';

import '../../../../core/exceptions/api_exceptions.dart';

abstract class DashboardSource {
  Future<DashboardResponseModel> getDashBoardData();
}

class DashboardSourceImpl implements DashboardSource {
  @override
  Future<DashboardResponseModel> getDashBoardData() async {
    try {
      // final Map<String, dynamic> response = await GetApiBase.instance.getApi(
      //   url: "",
      // );
      await Future.delayed(const Duration(seconds: 1));
      final DashboardResponseModel data = DashboardResponseModel.fromJson(_getData);
      return data;
    } catch (e) {
      throw AppException(e.toString());
    }
  }

  final Map<String, dynamic> _getData = {
    "statuscode": 200,
    "message": "Dashboard fetched successfully",
    "body": {
      "punchTime": {"punchInTime": "09:30 AM", "punchOutTime": "06:15 PM"},
      "lastPunches": [
        {"punchInTime": "09:28 AM", "punchOutTime": "06:10 PM"},
        {"punchInTime": "09:35 AM", "punchOutTime": "06:05 PM"}
      ]
    }
  };
}
