import 'package:get/get.dart';
import '../../../core/Enums/enums.dart';
import '../models/attendance_model.dart';
import '../services/attendance_service.dart';

class AttendanceController extends GetxController {
  final AttendanceService _service = AttendanceService();
  
   AttendanceData? _attendanceData ;
  AttendanceData? get attendanceData => _attendanceData;

  final Rx<ApiStatus> status = ApiStatus.loading.obs;

  @override
  void onInit() {
    super.onInit();
    fetchAttendance();
  }

  Future<void> fetchAttendance() async {
    status.value = ApiStatus.loading;
    try {
      _attendanceData = await _service.getAttendanceData();
      status.value = ApiStatus.completed;
    } catch (e) {
      status.value = ApiStatus.error;
    }
  }
}
