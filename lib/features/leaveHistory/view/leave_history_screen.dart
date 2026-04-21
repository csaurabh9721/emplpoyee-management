import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/utils/leave_utils.dart';
import '../../leaveManagementPage/models/leave_models.dart';

class LeaveHistoryScreen extends StatefulWidget {
  const LeaveHistoryScreen({super.key});

  @override
  State<LeaveHistoryScreen> createState() => _LeaveHistoryScreenState();
}

class _LeaveHistoryScreenState extends State<LeaveHistoryScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List<LeaveResponseModel> leaves = Get.arguments ?? [];

  List<LeaveResponseModel> getFilteredLeaves() {
    if (_tabController.index == 0) return leaves;
    final String status = _tabController.index == 1 ? "PENDING" : "APPROVED";
    return leaves
        .where((leave) => leave.status.toUpperCase() == status)
        .toList();
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F5F7),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: const BackButton(color: Colors.black),
        title: const Text(
          "Leave History",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: Icon(Icons.filter_list, color: Colors.black),
          )
        ],
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: const Color(0xFF1F2A7C),
          labelColor: const Color(0xFF1F2A7C),
          unselectedLabelColor: Colors.grey,
          onTap: (_) => setState(() {}),
          tabs: const [
            Tab(text: "All"),
            Tab(text: "Pending"),
            Tab(text: "Approved"),
          ],
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const Text(
            "CURRENT REQUESTS",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              letterSpacing: 1,
              color: Colors.black54,
            ),
          ),
          const SizedBox(height: 16),
          ...getFilteredLeaves().map((leave) => _leaveCard(leave)),
          const SizedBox(height: 30),
        ],
      ),
    );
  }

  Widget _leaveCard(LeaveResponseModel leave) {
    return Container(
      margin: const EdgeInsets.only(bottom: 18),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            blurRadius: 8,
            color: Colors.black.withOpacity(0.05),
          )
        ],
      ),
      child: Row(
        children: [
          Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              color: LeaveUtils.statusColor(leave.status).withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              LeaveUtils.getIconForStatus(leave.status),
              color: LeaveUtils.statusColor(leave.status),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  leave.type,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  leave.formattedDateRange,
                  style: const TextStyle(color: Colors.black54),
                ),
                const SizedBox(height: 4),
                Text(
                  "${leave.days} day${leave.days > 1 ? 's' : ''} total",
                  style: const TextStyle(color: Colors.black38),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: LeaveUtils.statusColor(leave.status).withOpacity(0.15),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              leave.status,
              style: TextStyle(
                color: LeaveUtils.statusColor(leave.status),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
