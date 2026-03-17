import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/utils/base_api_response.dart';
import '../models/leave_approval_model.dart';
import '../services/leave_approval_service.dart';

class LeaveApprovalController extends GetxController {
  final LeaveApprovalService _service = LeaveApprovalService();

  BaseApiResponse<List<LeaveApprovalModel>> pendingLeavesResponse = BaseApiResponse.initial();
  
  @override
  void onInit() {
    super.onInit();
    fetchPendingLeaves();
  }

  Future<void> fetchPendingLeaves() async {
    try {
      pendingLeavesResponse = BaseApiResponse.loading();
      update();

      final leaves = await _service.getPendingLeaves();
      pendingLeavesResponse = BaseApiResponse.success(data: leaves);
      update();
    } catch (e) {
      pendingLeavesResponse = BaseApiResponse.error(e.toString());
      update();
    }
  }

  Future<void> processLeave(String id, bool approve) async {
    try {
      final request = LeaveApprovalRequest(
        leaveId: id,
        status: approve ? 'Approved' : 'Rejected',
        remarks: approve ? 'Approved by Manager' : 'Rejected by Manager',
      );

      bool success;
      if (approve) {
        success = await _service.approveLeave(request);
      } else {
        success = await _service.rejectLeave(request);
      }

      if (success) {
        Get.snackbar(
          'Success',
          'Leave ${approve ? 'Approved' : 'Rejected'} successfully',
          backgroundColor: approve ? Colors.green : Colors.orange,
          colorText: Colors.white,
        );
        fetchPendingLeaves(); // Refresh list
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to process leave: $e',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }
}
