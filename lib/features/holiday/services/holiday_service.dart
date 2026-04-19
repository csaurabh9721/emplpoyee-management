import 'package:clientone_ess/core/exceptions/api_exceptions.dart';
import 'package:clientone_ess/core/network/apiClients/get_api_base.dart';
import 'package:clientone_ess/core/network/config/network_config.dart';
import '../../../shared/constants/local_stored_data.dart';
import '../models/holiday_model.dart';

class HolidayService {
  final GetApiBase _apiBase = GetApiBase.instance;

  Future<List<HolidayModel>> getHolidays() async {
    try {
      final Map<String, dynamic> response = await _apiBase.getApi(
          url: NetworkConfig.getAllHolidays+LocalStoredData.officeId.toString());
      
      if (response['statusCode'] != 200 || response['body'] == null) {
        throw Exception(
            response['message'] ?? "Failed to fetch holidays.");
      }
      
      return List.from(response['body'])
          .map((e) => HolidayModel.fromJson(e))
          .toList();
    } catch (e) {
      throw AppException("Failed to fetch holidays data.");
    }
  }
}
