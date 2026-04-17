import 'package:get/get.dart';
import '../../../core/utils/base_api_response.dart';
import '../models/dashboard_models.dart';
import '../models/punch_in_out_response.dart';
import '../services/dashboard_service.dart';

class DashboardController extends GetxController {
  final DashboardService _dashboardService = DashboardService();

  BaseApiResponse<DashboardDataModelBody> dashboardData = BaseApiResponse.loading();

  RxBool punchInOutLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    _loadBasicDashboardInfo();
  }

  Future<void> _loadBasicDashboardInfo() async {
    try {
      dashboardData = BaseApiResponse.loading();
      update();
      final DashboardDataModelBody data = await _dashboardService.getDashboardData();
      dashboardData = BaseApiResponse.success(data: data);
      update();
    } catch (e) {
      dashboardData = BaseApiResponse.error(e.toString());
      update();
    }
  }

  Future<void> punchInOut() async {
    punchInOutLoading.value = true;
    final PunchInOutResponse response =
        await _dashboardService.punchInOut(dashboardData.data!.employeeId, dashboardData.data!.organizationId);
    punchInOutLoading.value = false;
    if (response.statusCode == 201) {
      _loadBasicDashboardInfo();
    }
  }

  Future<void> refreshDashboard() async {
    _loadBasicDashboardInfo();
  }

  String get greeting {
    final hour = DateTime.now().hour;
    if (hour < 12) return 'Good Morning';
    if (hour < 17) return 'Good Afternoon';
    return 'Good Evening';
  }
}
