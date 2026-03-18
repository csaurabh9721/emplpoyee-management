import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/Enums/enums.dart';
import '../controllers/leave_approval_controller.dart';
import '../models/leave_approval_model.dart';

class LeaveApprovalScreen extends StatelessWidget {
  LeaveApprovalScreen({super.key});

  final LeaveApprovalController controller = Get.put(LeaveApprovalController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6FA),
      appBar: AppBar(
        title: const Text(
          'Leave Approvals',
          style: TextStyle(color: Color(0xFF2C3E50), fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF2C3E50)),
          onPressed: () => Get.back(),
        ),
      ),
      body: Column(
        children: [

          Expanded(child: GetBuilder<LeaveApprovalController>(
            builder: (controller) {
              if (controller.pendingLeavesResponse.status == ApiStatus.loading) {
                return const Center(child: CircularProgressIndicator());
              }

              if (controller.pendingLeavesResponse.status == ApiStatus.error) {
                return Center(child: Text(controller.pendingLeavesResponse.message));
              }

              final leaves = controller.pendingLeavesResponse.data ?? [];

              if (leaves.isEmpty) {
                return const Center(
                  child: Text(
                    'No pending leave requests',
                    style: TextStyle(fontSize: 16, color: Color(0xFF7F8C8D)),
                  ),
                );
              }

              return RefreshIndicator(
                onRefresh: controller.fetchPendingLeaves,
                child: ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: leaves.length,
                  itemBuilder: (context, index) {
                    return _LeaveApprovalCard(leave: leaves[index]);
                  },
                ),
              );
            },
          )),
        ],
      ),
    );
  }
}

class _LeaveApprovalCard extends StatelessWidget {
  final LeaveApprovalModel leave;
  final LeaveApprovalController controller = Get.find<LeaveApprovalController>();

  _LeaveApprovalCard({required this.leave});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      leave.employeeName,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF2C3E50),
                      ),
                    ),
                    Text(
                      leave.employeeId,
                      style: const TextStyle(
                        color: Color(0xFF3498DB),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                const Divider(height: 24),
                _InfoRow(label: 'Leave Type', value: leave.leaveType),
                _InfoRow(
                  label: 'Duration',
                  value: '${leave.startDate} - ${leave.endDate}',
                ),
                _InfoRow(label: 'Total Days', value: '${leave.totalDays} Day(s)'),
                _InfoRow(label: 'Reason', value: leave.reason),
                _InfoRow(
                  label: 'Applied On',
                  value: leave.appliedDate.toString(),
                ),
              ],
            ),
          ),
          Container(
            decoration: const BoxDecoration(
              color: Color(0xFFF8F9FA),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(12),
                bottomRight: Radius.circular(12),
              ),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => controller.processLeave(leave.id, false),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.red,
                      side: const BorderSide(color: Colors.red),
                    ),
                    child: const Text('Reject'),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => controller.processLeave(leave.id, true),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                    ),
                    child: const Text('Approve'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;

  const _InfoRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              label,
              style: const TextStyle(
                color: Color(0xFF7F8C8D),
                fontSize: 14,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                color: Color(0xFF2C3E50),
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
