import 'package:get/get.dart';
import '../../../core/Enums/enums.dart';
import '../models/account_balance_model.dart';
import '../services/account_balance_service.dart';

class AccountDetailController extends GetxController {
  final AccountBalanceService _service = AccountBalanceService();
  
  final Rx<AccountDetailModel?> accountDetail = Rx<AccountDetailModel?>(null);
  final Rx<ApiStatus> status = ApiStatus.loading.obs;

  @override
  void onInit() {
    super.onInit();
    final String? id = Get.parameters['id'];
    if (id != null) {
      fetchAccountDetail(id);
    } else {
      status.value = ApiStatus.error;
    }
  }

  Future<void> fetchAccountDetail(String id) async {
    status.value = ApiStatus.loading;
    update();
    try {
      accountDetail.value = await _service.getAccountDetail(id);
      status.value = ApiStatus.completed;
      update();
    } catch (e) {
      status.value = ApiStatus.error;
      update();
    }
  }
}
