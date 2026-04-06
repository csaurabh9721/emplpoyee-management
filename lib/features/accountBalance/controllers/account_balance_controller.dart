import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../core/Enums/enums.dart';
import '../models/account_balance_model.dart';
import '../services/account_balance_service.dart';

class AccountBalanceController extends GetxController {
  final AccountBalanceService _service = AccountBalanceService();
  
  final RxList<AccountBalanceModel> completedBalances = <AccountBalanceModel>[].obs;
  final RxList<AccountBalanceModel> pendingBalances = <AccountBalanceModel>[].obs;
  final Rx<ApiStatus> status = ApiStatus.loading.obs;

  final RxString selectedType = 'All'.obs;
  final Rx<DateTime> startDate = Rx<DateTime>(DateTime(DateTime.now().year, DateTime.now().month - 4, 1));
  final Rx<DateTime> endDate = Rx<DateTime>(DateTime.now());

  final List<String> types = ['All', 'Salary', 'Conveyance', 'Bonus', 'Others'];

  double get totalCompletedAmount => completedBalances.fold(0, (sum, item) => sum + item.amount);
  double get totalPendingAmount => pendingBalances.fold(0, (sum, item) => sum + item.amount);

  @override
  void onInit() {
    super.onInit();
    fetchBalances();
  }

  void setType(String? type) {
    if (type != null) {
      selectedType.value = type;
      fetchBalances();
    }
  }

  void setStartDate(DateTime date) {
    startDate.value = date;
    fetchBalances();
  }

  void setEndDate(DateTime date) {
    endDate.value = date;
    fetchBalances();
  }

  Future<void> fetchBalances() async {
    status.value = ApiStatus.loading;
    update();
    try {
      final data = await _service.getBalances(
        type: selectedType.value == 'All' ? null : selectedType.value,
        start: startDate.value,
        end: endDate.value,
      );
      
      List<AccountBalanceModel> filtered = data;
      if (selectedType.value != 'All') {
        filtered = data.where((e) => e.typeMember == selectedType.value).toList();
      }

      completedBalances.assignAll(filtered.where((e) => e.status == LedgerStatus.completed).toList());
      pendingBalances.assignAll(filtered.where((e) => e.status != LedgerStatus.completed).toList());
      
      status.value = ApiStatus.completed;
      update();
    } catch (e) {
      status.value = ApiStatus.error;
      update();
    }
  }

  String formatDate(DateTime date) => DateFormat('MMM yyyy').format(date);
}
