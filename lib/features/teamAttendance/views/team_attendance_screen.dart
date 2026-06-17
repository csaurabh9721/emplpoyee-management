import 'package:clientone_ess/shared/app_color.dart';
import 'package:clientone_ess/shared/constants/app_constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../controllers/team_attendance_controller.dart';
import '../models/team_attendance_model.dart';

class TeamAttendanceScreen extends StatelessWidget {
  TeamAttendanceScreen({super.key});

  final TeamAttendanceController _controller =
      Get.put(TeamAttendanceController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FD),
      appBar: AppBar(
        title: const Text('Team Attendance',
            style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: Obx(
        () => Column(
          children: <Widget>[
            Container(
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
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          decoration: BoxDecoration(
                            color: Colors.indigo.shade50,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            children: [
                              const Icon(Icons.calendar_month,
                                  size: 18, color: Colors.indigo),
                              const SizedBox(width: 8),
                              Text(
                                _controller.getMonthName(
                                    _controller.selectedMonth.value),
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.indigo),
                              ),
                              const Icon(Icons.arrow_drop_down,
                                  color: Colors.indigo),
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
                            value: _controller.selectedStatus.value,
                            isExpanded: true,
                            style: const TextStyle(
                                fontSize: 14,
                                color: Colors.black,
                                fontWeight: FontWeight.w500),
                            items:
                                _controller.statusFilters.map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            onChanged: _controller.onStatusChanged,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              height: 100,
              padding: const EdgeInsets.symmetric(vertical: 10),
              color: Colors.white,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: _controller.dates.length,
                itemBuilder: (context, index) {
                  final DateTime date = _controller.dates[index];
                  return GestureDetector(
                    onTap: () => _controller.onDateChanged(date, index),
                    child: Obx(
                      () => Container(
                        width: 60,
                        margin: const EdgeInsets.only(right: 12),
                        decoration: BoxDecoration(
                          color: _controller.selectedIndex.value == index
                              ? Colors.indigo
                              : Colors.grey.shade50,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                              color: _controller.selectedIndex.value == index
                                  ? Colors.indigo
                                  : Colors.grey.shade200),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              DateFormat('EEE').format(date),
                              style: TextStyle(
                                fontSize: 12,
                                color: _controller.selectedIndex.value == index
                                    ? Colors.white70
                                    : Colors.grey,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              date.day.toString(),
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: _controller.selectedIndex.value == index
                                    ? Colors.white
                                    : Colors.black87,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.all(20),
                itemCount: _controller.attendanceList.length,
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  return _EmployeeAttendanceCard(
                      attendance: _controller.attendanceList[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _selectMonth(BuildContext context) async {
    final RxInt selectedYear = DateTime.now().year.obs;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          insetPadding: const EdgeInsets.all(12),
          child: Obx(
            () => Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Select Month",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primaryDark,
                          ),
                        ),
                        PopupMenuButton<int>(
                          initialValue: selectedYear.value,
                          onSelected: (year) {
                            selectedYear.value = year;
                          },
                          itemBuilder: (context) {
                            return List.generate(
                              3,
                              (index) {
                                final year = DateTime.now().year - index;
                                return PopupMenuItem<int>(
                                  value: year,
                                  child: Text(
                                    year.toString(),
                                  ),
                                );
                              },
                            );
                          },
                          child: Card(
                            margin: EdgeInsets.zero,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 8,
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    selectedYear.toString(),
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const SizedBox(width: 6),
                                  const Icon(Icons.keyboard_arrow_down),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Divider(),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: GridView.builder(
                      shrinkWrap: true,
                      itemCount: AppConstant.monthList.length,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        mainAxisSpacing: 4,
                        crossAxisSpacing: 4,
                        childAspectRatio: 2.5,
                      ),
                      itemBuilder: (context, index) {
                        final String month = AppConstant.monthList[index];
                        final bool isDisable =
                            selectedYear.value == DateTime.now().year &&
                                AppConstant.getMonthIntMap[month]! >
                                    DateTime.now().month;

                        return InkWell(
                          borderRadius: BorderRadius.circular(8),
                          onTap: () {
                            if (isDisable) return;
                            final DateTime dateIs = DateTime(selectedYear.value,
                                AppConstant.getMonthIntMap[month]!);
                            Navigator.pop(context);
                            _controller.onMonthChanged(dateIs);
                          },
                          child: Card(
                            margin: EdgeInsets.zero,
                            color: isDisable
                                ? Colors.grey.shade300
                                : AppColors.white,
                            child: Center(
                              child: Text(
                                month,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _EmployeeAttendanceCard extends StatelessWidget {
  final AttendanceList attendance;

  const _EmployeeAttendanceCard({required this.attendance});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, 4))
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
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const SizedBox(height: 8),
                Text(attendance.getCombine,
                    style: const TextStyle(fontSize: 12)),
              ],
            ),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(attendance.workHour,
                  style: const TextStyle(fontWeight: FontWeight.w500)),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color:
                      _getStatusColor(attendance.status).withValues(alpha: 0.1),
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
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toUpperCase()) {
      case 'PRESENT':
        return Colors.green;
      case 'ABSENT':
        return Colors.red;
      case 'LATE':
        return Colors.orange;
      case 'HALF_DAY':
        return Colors.deepOrangeAccent;
      case 'HOLIDAY':
        return Colors.blue;
      default:
        return Colors.grey;
    }
  }
}
