import 'package:clientone_ess/core/routes/routes_name.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/leave_controller.dart';

class LeaveManagementPage extends StatelessWidget {
  LeaveManagementPage({super.key});

  final LeaveController controller = Get.put(LeaveController());

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xFFF4F6FA),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _TopBar(),
              SizedBox(height: 24),
              _LeaveBalanceSection(),
              SizedBox(height: 24),
              _RequestButton(),
              SizedBox(height: 30),
              _RecentRequestsSection(),
            ],
          ),
        ),
      ),
    );
  }
}

class _TopBar extends GetView<LeaveController> {
  const _TopBar();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.indigo.shade50,
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Icon(Icons.arrow_back, color: Colors.indigo),
        ),
        const Spacer(),
        const Text(
          "Leave Management",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const Spacer(),
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.indigo.shade50,
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Icon(Icons.notifications, color: Colors.indigo),
        ),
      ],
    );
  }
}

class _LeaveBalanceSection extends GetView<LeaveController> {
  const _LeaveBalanceSection();

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Leave Balance",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 6),
        Text(
          "Your available days for this year",
          style: TextStyle(color: Colors.grey),
        ),
        SizedBox(height: 20),
        Row(
          children: [
            Expanded(
              child: _BalanceCard(
                icon: Icons.calendar_today,
                title: "Annual",
                days: "12",
                color: Colors.indigo,
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: _BalanceCard(
                icon: Icons.medical_services,
                title: "Sick",
                days: "5",
                color: Colors.green,
              ),
            ),
          ],
        ),
        SizedBox(height: 16),
        _BalanceCard(
          icon: Icons.person,
          title: "Personal",
          days: "3",
          color: Colors.orange,
          fullWidth: true,
        ),
      ],
    );
  }
}

class _BalanceCard  extends GetView<LeaveController> {
  final IconData icon;
  final String title;
  final String days;
  final Color color;
  final bool fullWidth;

  const _BalanceCard({
    required this.icon,
    required this.title,
    required this.days,
    required this.color,
    this.fullWidth = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: fullWidth ? double.infinity : null,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6,
            offset: Offset(0, 4),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: color),
          ),
          const SizedBox(height: 16),
          Text(title, style: const TextStyle(fontSize: 16)),
          const SizedBox(height: 8),
          RichText(
            text: TextSpan(
              text: days,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: color,
              ),
              children: const [
                TextSpan(
                  text: " DAYS",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _RequestButton  extends GetView<LeaveController> {
  const _RequestButton();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 55,
      child: ElevatedButton.icon(
        onPressed: () {
          Get.toNamed(RoutesName.applyLeavePage);
        },
        icon: const Icon(Icons.add),
        label: const Text("Request Leave"),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.indigo,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),
    );
  }
}

class _RecentRequestsSection  extends GetView<LeaveController> {
  const _RecentRequestsSection();

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Recent Requests",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(
              "View All",
              style: TextStyle(
                color: Colors.indigo,
                fontWeight: FontWeight.w500,
              ),
            )
          ],
        ),
        SizedBox(height: 6),
        Text(
          "Status of your latest applications",
          style: TextStyle(color: Colors.grey),
        ),
        SizedBox(height: 20),
        _LeaveRequestTile(
          title: "Annual Leave",
          date: "Oct 12 - Oct 15, 2023 (4 days)",
          status: "PENDING",
          statusColor: Colors.orange,
        ),
        SizedBox(height: 14),
        _LeaveRequestTile(
          title: "Sick Leave",
          date: "Sep 20, 2023 (1 day)",
          status: "APPROVED",
          statusColor: Colors.green,
        ),
        SizedBox(height: 14),
        _LeaveRequestTile(
          title: "Personal Leave",
          date: "Aug 05 - Aug 06, 2023 (2 days)",
          status: "REJECTED",
          statusColor: Colors.red,
        ),
        SizedBox(height: 14),
        _LeaveRequestTile(
          title: "Annual Leave",
          date: "Jul 10 - Jul 14, 2023 (5 days)",
          status: "APPROVED",
          statusColor: Colors.green,
        ),
      ],
    );
  }
}

class _LeaveRequestTile  extends GetView<LeaveController> {
  final String title;
  final String date;
  final String status;
  final Color statusColor;

  const _LeaveRequestTile({
    required this.title,
    required this.date,
    required this.status,
    required this.statusColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6,
            offset: Offset(0, 4),
          )
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      title,
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(width: 10),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: statusColor.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        status,
                        style: TextStyle(
                          color: statusColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.calendar_today, size: 16, color: Colors.grey),
                    const SizedBox(width: 6),
                    Text(date, style: const TextStyle(color: Colors.grey)),
                  ],
                )
              ],
            ),
          ),
          const Icon(Icons.chevron_right, color: Colors.grey),
        ],
      ),
    );
  }
}
