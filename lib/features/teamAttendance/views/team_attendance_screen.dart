import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../core/Enums/enums.dart';
import '../controllers/team_attendance_controller.dart';
import '../models/team_attendance_model.dart';

class TeamAttendanceScreen extends GetView<TeamAttendanceController> {
  const TeamAttendanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FD),
      appBar: AppBar(
        title: const Text('Team Attendance', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: GetBuilder<TeamAttendanceController>(
        init: TeamAttendanceController(),
        builder: (controller) {
          return Column(
            children: [
              _HeaderSection(controller: controller),
              _DateTimeline(controller: controller),
              Expanded(
                child: _buildAttendanceList(controller),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildAttendanceList(TeamAttendanceController controller) {
    if (controller.status.value == ApiStatus.loading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (controller.status.value == ApiStatus.error) {
      return const Center(child: Text('Error loading attendance'));
    }
    if (controller.teamAttendance.isEmpty) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.person_off_outlined, size: 60, color: Colors.grey),
            SizedBox(height: 16),
            Text('No records found for this day', style: TextStyle(color: Colors.grey)),
          ],
        ),
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.all(20),
      itemCount: controller.teamAttendance.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        return _EmployeeAttendanceCard(attendance: controller.teamAttendance[index]);
      },
    );
  }
}

class _HeaderSection extends StatelessWidget {
  final TeamAttendanceController controller;
  const _HeaderSection({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      color: Colors.white,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () => _selectMonth(context),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.indigo.shade50,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.calendar_month, size: 18, color: Colors.indigo),
                      const SizedBox(width: 8),
                      Text(
                        controller.getMonthName(controller.selectedMonth.value),
                        style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.indigo),
                      ),
                      const Icon(Icons.arrow_drop_down, color: Colors.indigo),
                    ],
                  ),
                ),
              ),
              Container(
                width: 120,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: controller.selectedStatus.value,
                    isExpanded: true,
                    style: const TextStyle(fontSize: 14, color: Colors.black, fontWeight: FontWeight.w500),
                    items: controller.statusFilters.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: controller.onStatusChanged,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> _selectMonth(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: controller.selectedMonth.value,
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
      initialDatePickerMode: DatePickerMode.year,
    );
    if (picked != null) {
      controller.onMonthChanged(DateTime(picked.year, picked.month, 1));
    }
  }
}

class _DateTimeline extends StatefulWidget {
  final TeamAttendanceController controller;
  const _DateTimeline({required this.controller});

  @override
  State<_DateTimeline> createState() => _DateTimelineState();
}

class _DateTimelineState extends State<_DateTimeline> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToSelectedDate();
    });
  }

  void _scrollToSelectedDate() {
    final index = widget.controller.selectedDate.value.day - 1;
    if (index > 0) {
      _scrollController.animateTo(
        index * 70.0,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      padding: const EdgeInsets.symmetric(vertical: 10),
      color: Colors.white,
      child: Obx(() => ListView.builder(
            controller: _scrollController,
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: widget.controller.monthDates.length,
            itemBuilder: (context, index) {
              final date = widget.controller.monthDates[index];
              final isSelected = widget.controller.selectedDate.value.day == date.day &&
                  widget.controller.selectedDate.value.month == date.month;

              return GestureDetector(
                onTap: () => widget.controller.onDateChanged(date),
                child: Container(
                  width: 60,
                  margin: const EdgeInsets.only(right: 12),
                  decoration: BoxDecoration(
                    color: isSelected ? Colors.indigo : Colors.grey.shade50,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: isSelected ? Colors.indigo : Colors.grey.shade200),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        DateFormat('EEE').format(date),
                        style: TextStyle(
                          fontSize: 12,
                          color: isSelected ? Colors.white70 : Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        date.day.toString(),
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: isSelected ? Colors.white : Colors.black87,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          )),
    );
  }
}

class _EmployeeAttendanceCard extends StatelessWidget {
  final TeamAttendanceModel attendance;
  const _EmployeeAttendanceCard({required this.attendance});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 4))
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 25,
            backgroundImage: NetworkImage(attendance.avatar),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  attendance.employeeName,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                Text(
                  attendance.designation,
                  style: const TextStyle(color: Colors.grey, fontSize: 13),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.login_outlined, size: 14, color: Colors.green),
                    const SizedBox(width: 4),
                    Text(attendance.checkIn, style: const TextStyle(fontSize: 12)),
                    const SizedBox(width: 12),
                    const Icon(Icons.logout_outlined, size: 14, color: Colors.orange),
                    const SizedBox(width: 4),
                    Text(attendance.checkOut, style: const TextStyle(fontSize: 12)),
                  ],
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: _getStatusColor(attendance.status).withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              attendance.status,
              style: TextStyle(
                color: _getStatusColor(attendance.status),
                fontWeight: FontWeight.bold,
                fontSize: 11,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Present': return Colors.green;
      case 'Absent': return Colors.red;
      case 'Half Day': return Colors.orange;
      default: return Colors.grey;
    }
  }
}
