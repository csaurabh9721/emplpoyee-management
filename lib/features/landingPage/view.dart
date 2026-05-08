import 'package:clientone_ess/features/attendance/views/attendance_screen.dart';
import 'package:clientone_ess/features/dashboard/views/dashboard_screen.dart';
import 'package:clientone_ess/features/landingPage/controller.dart';
import 'package:clientone_ess/features/profile/views/profile_screen.dart';
import 'package:clientone_ess/shared/app_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LandingPage extends StatelessWidget {
  LandingPage({super.key});

  final LandingPageController _controller = Get.put(LandingPageController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Obx(
        () => _controller.selectedIndex.value == 0
            ? DashboardScreen()
            : _controller.selectedIndex.value == 1
                ? const AttendanceScreen()
                : ProfileScreen(),
      ),
      bottomNavigationBar: Obx(
        () => Card(
          elevation: 5,
          margin: const EdgeInsets.all(0),
          color: AppColors.white,
          surfaceTintColor: AppColors.white,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 5.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _item(Icons.dashboard, "Dashboard", 0),
                _item(Icons.calendar_month, "Attendance", 1),
                _item(Icons.person, "Profile", 2),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _item(IconData icon, String label, int index) {
    final bool isSelected = _controller.selectedIndex.value == index;

    return InkWell(
      onTap: () => _controller.changeTab(index),
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: isSelected ? AppColors.primaryDark : Colors.grey,
            size: 22,
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: TextStyle(
                color: isSelected ? AppColors.primaryDark : Colors.grey, fontSize: 10, fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }
}
