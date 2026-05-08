import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../core/Enums/enums.dart';
import '../models/team_attendance_model.dart';
import '../services/team_attendance_service.dart';

class TeamAttendanceController extends GetxController {
  final Rx<DateTime> selectedMonth = DateTime.now().obs;
  final RxInt selectedIndex = 0.obs;
  final RxList<AttendanceList> attendanceList = <AttendanceList>[].obs;
  final Rx<ApiStatus> status = ApiStatus.loading.obs;
  final RxString selectedStatus = 'All'.obs;
  final List<String> statusFilters = ['All', 'Present', 'Absent', 'Half Day'];
  RxList<TeamAttendanceModel> data = <TeamAttendanceModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    _fetchTeamAttendance();
  }

  void onMonthChanged(DateTime date) {
    selectedMonth.value = date;
    selectedIndex.value = 0;
    _fetchTeamAttendance();
  }

  void onDateChanged(DateTime date, int index) {
    selectedIndex.value = index;
    attendanceList.clear();
    attendanceList.addAll(data.firstWhere((e) => e.attendanceDate == date).attendanceList);
  }

  void onStatusChanged(String? status) {
    if (status != null) {
      selectedStatus.value = status;
    }
  }

  Future<void> _fetchTeamAttendance() async {
    status.value = ApiStatus.loading;
    update();
    try {
      final DateTime startDate = DateTime(selectedMonth.value.year, selectedMonth.value.month, 1);
      DateTime endDate = DateTime(selectedMonth.value.year, selectedMonth.value.month + 1, 0);
      endDate = endDate.isAfter(DateTime.now()) ? DateTime.now() : endDate;
      data.value = await TeamAttendanceService().getTeamAttendanceData(startDate, endDate);
      attendanceList.clear();
      attendanceList.addAll(data.first.attendanceList);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  String getMonthName(DateTime date) => DateFormat('MMMM yyyy').format(date);
}
