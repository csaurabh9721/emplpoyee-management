import 'package:get/get.dart';
import '../../../core/Enums/enums.dart';
import '../models/holiday_model.dart';
import '../services/holiday_service.dart';

class HolidayController extends GetxController {
  final HolidayService _service = HolidayService();
  
  final Rx<ApiStatus> status = ApiStatus.loading.obs;
  final RxList<HolidayModel> holidays = <HolidayModel>[].obs;
  final RxInt currentYear = DateTime.now().year.obs;

  @override
  void onInit() {
    super.onInit();
    fetchHolidays();
  }

  Future<void> fetchHolidays() async {
    status.value = ApiStatus.loading;
    try {
      final fetchedHolidays = await _service.getHolidays();
      // Filter for current year if needed, but usually the API handles this
      // For now, we show what the API returns
      holidays.assignAll(fetchedHolidays);
      status.value = ApiStatus.completed;
    } catch (e) {
      status.value = ApiStatus.error;
    }
  }

  List<HolidayModel> get upcomingHolidays {
    final now = DateTime.now();
    return holidays.where((h) => h.date.isAfter(now) || h.date.isAtSameMomentAs(now)).toList();
  }

  List<HolidayModel> get pastHolidays {
    final now = DateTime.now();
    return holidays.where((h) => h.date.isBefore(now)).toList();
  }
}
