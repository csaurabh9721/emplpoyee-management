import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/Enums/enums.dart';
import '../controllers/attendance_controller.dart';
import '../models/attendance_model.dart';

class AttendanceScreen extends StatelessWidget {
  const AttendanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
  final  AttendanceController controller = Get.put(AttendanceController());
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6FA),
      appBar: AppBar(
        title: const Text('Attendance'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: Obx(
         () {
          if (controller.status.value == ApiStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (controller.status.value == ApiStatus.error) {
            return const Center(child: Text('Error loading attendance'));
          }
          final data = controller.attendanceData;
          return RefreshIndicator(
            onRefresh: controller.fetchAttendance,
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (data?.today != null) ...[
                    const Text(
                      'Today\'s Attendance',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 16),
                    _TodayCard(attendance: data!.today!),
                    const SizedBox(height: 24),
                  ],
                  const Text(
                    'History',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 16),
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: data?.history.length ?? 0,
                    separatorBuilder: (_, __) => const SizedBox(height: 12),
                    itemBuilder: (context, index) {
                      return _HistoryCard(attendance: data!.history[index]);
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _TodayCard extends StatelessWidget {
  final AttendanceModel attendance;
  const _TodayCard({required this.attendance});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.indigo,
        borderRadius: BorderRadius.circular(20),
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Check In', style: TextStyle(color: Colors.white70)),
                  const SizedBox(height: 4),
                  Text(attendance.checkIn, style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                ],
              ),
              const Icon(Icons.arrow_forward, color: Colors.white70),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const Text('Check Out', style: TextStyle(color: Colors.white70)),
                  const SizedBox(height: 4),
                  Text(attendance.checkOut ?? '--:--', style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                ],
              ),
            ],
          ),
          const Divider(color: Colors.white24, height: 32),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _TodayStat(label: 'Date', value: attendance.date),
              _TodayStat(label: 'Working Hours', value: attendance.workingHours),
            ],
          )
        ],
      ),
    );
  }
}

class _TodayStat extends StatelessWidget {
  final String label;
  final String value;
  const _TodayStat({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(color: Colors.white70, fontSize: 12)),
        const SizedBox(height: 2),
        Text(value, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
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
              color: attendance.status == 'Present' ? Colors.green.shade50 : Colors.red.shade50,
              shape: BoxShape.circle,
            ),
            child: Icon(
              attendance.status == 'Present' ? Icons.check : Icons.close,
              color: attendance.status == 'Present' ? Colors.green : Colors.red,
              size: 20,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(attendance.date, style: const TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                Text('${attendance.checkIn} - ${attendance.checkOut}', style: TextStyle(color: Colors.grey.shade600, fontSize: 12)),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(attendance.workingHours, style: const TextStyle(fontWeight: FontWeight.w500)),
              Text(attendance.status, style: TextStyle(color: attendance.status == 'Present' ? Colors.green : Colors.red, fontSize: 12)),
            ],
          )
        ],
      ),
    );
  }
}
