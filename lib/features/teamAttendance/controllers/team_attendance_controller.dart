import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../core/Enums/enums.dart';
import '../models/team_attendance_model.dart';
import '../services/team_attendance_service.dart';

class TeamAttendanceController extends GetxController {
  final TeamAttendanceService _service = TeamAttendanceService();

  final Rx<DateTime> selectedMonth = DateTime.now().obs;
  final Rx<DateTime> selectedDate = DateTime.now().obs;
  final RxString selectedStatus = 'All'.obs;
  final RxList<DateTime> monthDates = <DateTime>[].obs;
  final RxList<TeamAttendanceModel> teamAttendance = <TeamAttendanceModel>[].obs;
  final Rx<ApiStatus> status = ApiStatus.loading.obs;

  final List<String> statusFilters = ['All', 'Present', 'Absent', 'Half Day'];

  @override
  void onInit() {
    super.onInit();
    _generateMonthDates();
    fetchTeamAttendance();
  }

  void _generateMonthDates() {
    final daysInMonth = DateTime(selectedMonth.value.year, selectedMonth.value.month + 1, 0).day;
    monthDates.value = List.generate(
      daysInMonth,
      (index) => DateTime(selectedMonth.value.year, selectedMonth.value.month, index + 1),
    );
  }

  void onMonthChanged(DateTime date) {
    selectedMonth.value = date;
    _generateMonthDates();
    // If current selected date is not in the new month, default to 1st
    if (selectedDate.value.month != date.month || selectedDate.value.year != date.year) {
      selectedDate.value = DateTime(date.year, date.month, 1);
    }
    fetchTeamAttendance();
  }

  void onDateChanged(DateTime date) {
    selectedDate.value = date;
    fetchTeamAttendance();
  }

  void onStatusChanged(String? status) {
    if (status != null) {
      selectedStatus.value = status;
      fetchTeamAttendance();
    }
  }

  Future<void> fetchTeamAttendance() async {
    status.value = ApiStatus.loading;
    update();
    try {
      final data = await _service.getTeamAttendance(selectedDate.value, selectedStatus.value);
      teamAttendance.assignAll(data);
      status.value = ApiStatus.completed;
      update();
    } catch (e) {
      status.value = ApiStatus.error;
      update();
    }
  }

  String getMonthName(DateTime date) => DateFormat('MMMM yyyy').format(date);
}
