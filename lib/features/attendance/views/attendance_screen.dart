import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/Enums/enums.dart';
import '../../../core/utils/date_formatter.dart';
import '../../dashboard/models/dashboard_models.dart';
import '../controllers/attendance_controller.dart';
import '../models/attendance_model.dart';

class AttendanceScreen extends StatelessWidget {
  const AttendanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AttendanceController controller = Get.put(AttendanceController());
    final TodayAttendance? todayAttendance = Get.arguments;
    return Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: const Text('Attendance'),
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          elevation: 0,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (todayAttendance != null) ...[
                const Text(
                  'Today\'s Attendance',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                _TodayCard(attendance: todayAttendance),
                const SizedBox(height: 16),
              ],
              InkWell(
                onTap: () {
                  _showFilterBottomSheet(context, controller);
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.list_alt),
                    Obx(
                      () => Text(
                        " ${controller.startDate.value.ddMmYyyy()} - ${controller.endDate.value.ddMmYyyy()} | ${controller.selectedStatus.value} ",
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const Icon(Icons.arrow_drop_down),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              Obx(
                () {
                  if (controller.status.value == ApiStatus.loading) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (controller.status.value == ApiStatus.error) {
                    return const Center(
                        child: Text('Error loading attendance'));
                  }
                  if (controller.filteredAttendanceData.isEmpty) {
                    return const Center(
                        child: Text('No attendance records found'));
                  }
                  return ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: controller.filteredAttendanceData.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 12),
                    itemBuilder: (context, index) {
                      return _HistoryCard(
                          attendance: controller.filteredAttendanceData[index]);
                    },
                  );
                },
              ),
            ],
          ),
        ));
  }

  void _showFilterBottomSheet(
      BuildContext context, AttendanceController controller) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            left: 20,
            right: 20,
            top: 20,
            bottom: MediaQuery.of(context).viewInsets.bottom + 20,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Filter Attendance',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: _DateField(
                      label: 'Start Date',
                      initialDate: controller.startDate.value,
                      onDateSelected: (date) {
                        controller.startDate.value = date;
                      },
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _DateField(
                      label: 'End Date',
                      initialDate: controller.endDate.value,
                      onDateSelected: (date) {
                        controller.endDate.value = date;
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const Text('Status',
                  style: TextStyle(fontWeight: FontWeight.w500)),
              const SizedBox(height: 8),
              Obx(() => Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        isExpanded: true,
                        value: controller.selectedStatus.value,
                        items: controller.statusOptions.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (value) {
                          controller.updateStatus(value);
                        },
                      ),
                    ),
                  )),
              const SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.indigo,
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  onPressed: () {
                    controller.fetchAttendance();
                    Navigator.pop(context);
                  },
                  child: const Text('Apply Filter',
                      style: TextStyle(color: Colors.white, fontSize: 16)),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _DateField extends StatefulWidget {
  final String label;
  final DateTime initialDate;
  final Function(DateTime) onDateSelected;

  const _DateField({
    required this.label,
    required this.initialDate,
    required this.onDateSelected,
  });

  @override
  State<_DateField> createState() => _DateFieldState();
}

class _DateFieldState extends State<_DateField> {
  late DateTime selectedDate;

  @override
  void initState() {
    super.initState();
    selectedDate = widget.initialDate;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.label, style: const TextStyle(fontWeight: FontWeight.w500)),
        const SizedBox(height: 8),
        InkWell(
          onTap: () async {
            final DateTime? picked = await showDatePicker(
              context: context,
              initialDate: selectedDate,
              firstDate: DateTime(2020),
              lastDate: DateTime.now(),
            );
            if (picked != null && picked != selectedDate) {
              setState(() {
                selectedDate = picked;
              });
              widget.onDateSelected(picked);
            }
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(selectedDate.ddMmYyyy()),
                const Icon(Icons.calendar_today,
                    size: 18, color: Colors.indigo),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _TodayCard extends StatelessWidget {
  final TodayAttendance attendance;

  const _TodayCard({required this.attendance});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.indigo,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.indigo.withValues(alpha: 0.3),
            blurRadius: 10,
            offset: const Offset(0, 5),
          )
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                flex: 3,
                child: _widget(
                    label: 'Check IN',
                    value: attendance.getFormattedPunchInTime),
              ),
              const Expanded(
                  flex: 1,
                  child: Center(
                      child: Icon(
                    Icons.arrow_forward,
                    color: Colors.white70,
                    size: 20,
                  ))),
              Expanded(
                flex: 3,
                child: Align(
                  alignment: AlignmentGeometry.centerRight,
                  child: _widget(
                      label: 'Check Out',
                      value: attendance.getFormattedPunchOutTime),
                ),
              ),
              Expanded(
                flex: 5,
                child: Align(
                  alignment: AlignmentGeometry.centerRight,
                  child: _widget(
                      label: 'Working Hours', value: attendance.workHour),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _widget({required String label, required String value}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: const TextStyle(color: Colors.white70, fontSize: 12)),
        const SizedBox(height: 2),
        Text(value,
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.w600)),
      ],
    );
  }
}

class _HistoryCard extends StatelessWidget {
  final AttendanceModel attendance;

  const _HistoryCard({required this.attendance});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: _getStatusColor(attendance.status).withAlpha(50),
              shape: BoxShape.circle,
            ),
            child: Icon(
              _getStatusIcon(attendance.status),
              color: _getStatusColor(attendance.status),
              size: 20,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(attendance.getFormattedDate,
                    style: const TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                if (attendance.getFormattedPunchInTime.isNotEmpty &&
                    attendance.getFormattedPunchOutTime.isNotEmpty)
                  Text(
                      '${attendance.getFormattedPunchInTime} - ${attendance.getFormattedPunchOutTime}',
                      style:
                          TextStyle(color: Colors.grey.shade600, fontSize: 12)),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(attendance.workHour,
                  style: const TextStyle(fontWeight: FontWeight.w500)),
              Text(attendance.status,
                  style: TextStyle(
                      color: _getStatusColor(attendance.status), fontSize: 12)),
            ],
          )
        ],
      ),
    );
  }

  IconData _getStatusIcon(String status) {
    switch (status.toUpperCase()) {
      case 'PRESENT':
        return Icons.check;
      case 'ABSENT':
        return Icons.close;
      case 'LATE':
        return Icons.warning;
      case 'HOLIDAY':
        return Icons.festival;
      default:
        return Icons.info;
    }
  }

  Color _getStatusColor(String status) {
    switch (status.toUpperCase()) {
      case 'PRESENT':
        return Colors.green;
      case 'ABSENT':
        return Colors.red;
      case 'LATE':
        return Colors.orange;
      case 'HOLIDAY':
        return Colors.blue;
      default:
        return Colors.grey;
    }
  }
}
