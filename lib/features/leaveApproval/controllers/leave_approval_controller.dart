import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/utils/base_api_response.dart';
import '../../leaveManagementPage/models/leave_models.dart';
import '../services/leave_approval_service.dart';

class LeaveApprovalController extends GetxController {
  final LeaveApprovalService _service = LeaveApprovalService();

  BaseApiResponse<List<LeaveResponseModel>> pendingLeavesResponse = BaseApiResponse.initial();

  @override
  void onInit() {
    super.onInit();
    fetchPendingLeaves();
  }

  Future<void> fetchPendingLeaves() async {
    await _fetchPendingLeaves();
  }


  Future<void> _fetchPendingLeaves() async {
    try {
      pendingLeavesResponse = BaseApiResponse.loading();
      update();
      final leaves = await _service.getAllAppliedLeaveRequests();
      pendingLeavesResponse = BaseApiResponse.success(data: leaves);
      update();
    } catch (e) {
      pendingLeavesResponse = BaseApiResponse.error(e.toString());
      update();
    }
  }

  Future<void> approveLeave(int id) async {
    try {
      final String response = await _service.approveLeave(id);
      Get.snackbar(
        'Success',
        response,
        backgroundColor: Colors.green,
        colorText: Colors.white,
        duration: const Duration(seconds: 3),
      );
      _fetchPendingLeaves();
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

  Future<void> rejectLeave(int id) async {
    try {
      final String response = await _service.rejectLeave(id);
      Get.snackbar(
        'Success',
        response,
        backgroundColor: Colors.green,
        colorText: Colors.white,
        duration: const Duration(seconds: 3),
      );
      _fetchPendingLeaves();
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
