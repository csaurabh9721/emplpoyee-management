import 'package:flutter/material.dart';

class LeaveHistoryScreen extends StatefulWidget {
  const LeaveHistoryScreen({super.key});

  @override
  State<LeaveHistoryScreen> createState() => _LeaveHistoryScreenState();
}

enum LeaveStatus { approved, pending, completed, rejected }

class LeaveModel {
  final String title;
  final DateTime startDate;
  final DateTime? endDate;
  final LeaveStatus status;

  LeaveModel({
    required this.title,
    required this.startDate,
    this.endDate,
    required this.status,
  });

  int get totalDays {
    if (endDate == null) return 1;
    return endDate!.difference(startDate).inDays + 1;
  }
}

class _LeaveHistoryScreenState extends State<LeaveHistoryScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List<LeaveModel> _leaves = [
    LeaveModel(
      title: "Annual Leave",
      startDate: DateTime(2023, 10, 24),
      endDate: DateTime(2023, 10, 26),
      status: LeaveStatus.approved,
    ),
    LeaveModel(
      title: "Sick Leave",
      startDate: DateTime(2023, 11, 12),
      status: LeaveStatus.pending,
    ),
    LeaveModel(
      title: "Casual Leave",
      startDate: DateTime(2023, 8, 15),
      endDate: DateTime(2023, 8, 16),
      status: LeaveStatus.completed,
    ),
    LeaveModel(
      title: "Personal Leave",
      startDate: DateTime(2023, 7, 4),
      status: LeaveStatus.rejected,
    ),
    LeaveModel(
      title: "Bereavement Leave",
      startDate: DateTime(2023, 5, 10),
      endDate: DateTime(2023, 5, 13),
      status: LeaveStatus.completed,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  List<LeaveModel> getFilteredLeaves() {
    switch (_tabController.index) {
      case 1:
        return _leaves
            .where((e) => e.status == LeaveStatus.pending)
            .toList();
      case 2:
        return _leaves
            .where((e) => e.status == LeaveStatus.approved)
            .toList();
      default:
        return _leaves;
    }
  }

  String formatDateRange(LeaveModel leave) { const List<String> months = [
    'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
    'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
  ];
      return '${leave.endDate!.day} ${months[leave.endDate!.month - 1]} ${leave.endDate!.year}';
  }

  Color statusColor(LeaveStatus status) {
    switch (status) {
      case LeaveStatus.approved:
        return Colors.green;
      case LeaveStatus.pending:
        return Colors.orange;
      case LeaveStatus.completed:
        return Colors.grey;
      case LeaveStatus.rejected:
        return Colors.red;
    }
  }

  String statusText(LeaveStatus status) {
    return status.name.toUpperCase();
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

  Widget _leaveCard(LeaveModel leave) {
    return Container(
      margin: const EdgeInsets.only(bottom: 18),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            blurRadius: 8,
            color: Colors.black.withOpacity(.05),
          )
        ],
      ),
      child: Row(
        children: [
          Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              color: statusColor(leave.status).withOpacity(.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              Icons.calendar_month,
              color: statusColor(leave.status),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  leave.title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  formatDateRange(leave),
                  style: const TextStyle(color: Colors.black54),
                ),
                const SizedBox(height: 4),
                Text(
                  "${leave.totalDays} day${leave.totalDays > 1 ? 's' : ''} total",
                  style: const TextStyle(color: Colors.black38),
                ),
              ],
            ),
          ),
          Container(
            padding:
            const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: statusColor(leave.status).withOpacity(.15),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              statusText(leave.status),
              style: TextStyle(
                color: statusColor(leave.status),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}