import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../leaveManagementPage/models/leave_models.dart';
import '../services/leave_withdrawn_service.dart';

class LeaveHistoryController extends GetxController {
  final List<LeaveResponseModel> leaves = Get.arguments ?? [];

  final RxString _selectedFilter = "ALL".obs;

  String get selectedFilter => _selectedFilter.value;

  final List<String> filters = ["ALL", "PENDING", "APPROVED", "REJECTED", "WITHDRAWN"];

  void setFilter(String value) {
    _selectedFilter.value = value;
  }

  List<LeaveResponseModel> get filteredLeaves {
    if (selectedFilter == "ALL") return leaves;
    return leaves.where((leave) => leave.status.toUpperCase() == selectedFilter).toList();
  }

  int getCount(String status) {
    if (status == "ALL") return leaves.length;
    return leaves.where((l) => l.status.toUpperCase() == status).length;
  }

  void withdrawLeave(int leaveId) async {
    try {
      final String response = await LeaveWithdrawnService().withdrawLeave(leaveId);
      Get.back(result: true);
      Get.snackbar(
        'Success',
        response,
        backgroundColor: Colors.green,
        colorText: Colors.white,
        duration: const Duration(seconds: 3),
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        e.toString(),
        backgroundColor: Colors.red,
        colorText: Colors.white,
        duration: const Duration(seconds: 3),
      );
    }
  }
}
