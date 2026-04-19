import 'package:get/get.dart';
import '../../../core/Enums/enums.dart';
import '../models/attendance_model.dart';
import '../services/attendance_service.dart';

class AttendanceController extends GetxController {
  final AttendanceService _service = AttendanceService();

  List<AttendanceModel> attendanceData = [] ;

  final Rx<ApiStatus> status = ApiStatus.loading.obs;

   Rx<DateTime> startDate = DateTime.now().subtract(const Duration(days: 30)).obs;
  Rx<DateTime> endDate = DateTime.now().obs;
  RxString selectedStatus = 'ALL'.obs;

  final List<String> statusOptions = [
    'ALL',
    'PRESENT',
    'ABSENT',
    'LEAVE',
    'WEEK_OFF',
    'HOLIDAY',
    'HALF_DAY',
    'LATE'
  ];

  List<AttendanceModel> _allAttendanceData = [];
  final RxList<AttendanceModel> filteredAttendanceData = <AttendanceModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchAttendance();
  }

  Future<void> fetchAttendance() async {
    status.value = ApiStatus.loading;
    try {
      _allAttendanceData = await _service.getAttendanceData(startDate.value, endDate.value);
      applyFilter();
      status.value = ApiStatus.completed;
    } catch (e) {
      status.value = ApiStatus.error;
    }
  }

  void applyFilter() {
    if (selectedStatus.value == 'ALL') {
      filteredAttendanceData.assignAll(_allAttendanceData);
    } else {
      filteredAttendanceData.assignAll(
        _allAttendanceData.where((element) => element.status.toUpperCase() == selectedStatus.value).toList(),
      );
    }
  }

  void updateDates(DateTime start, DateTime end) {
    startDate.value = start;
    endDate.value = end;
    fetchAttendance();
  }

  void updateStatus(String? status) {
    if (status != null) {
      selectedStatus.value = status;
      applyFilter();
    }
  }
}
