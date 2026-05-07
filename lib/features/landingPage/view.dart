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
      body: Obx(
        () => IndexedStack(
          index: _controller.selectedIndex.value,
          children: [
            DashboardScreen(),
            const AttendanceScreen(),
            ProfileScreen(),
          ],
        ),
      ),
      bottomNavigationBar: Obx(
        () => Container(
          padding: EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
            boxShadow: [
              /// Main soft shadow (depth)
              BoxShadow(
                color: Colors.black.withOpacity(0.08),
                blurRadius: 15,
                spreadRadius: 1,
                offset: const Offset(-2, -2),
              ),

              /// Light top highlight (premium feel)
              BoxShadow(
                color: Colors.white.withOpacity(0.8),
                blurRadius: 8,
                spreadRadius: 1,
                offset: const Offset(-2, -2),
              ),
            ],
          ),
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
    );
  }

  Widget _item(IconData icon, String label, int index) {
    final bool isSelected = _controller.selectedIndex.value == index;

    return InkWell(
      onTap: () => _controller.changeTab(index),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: isSelected ? AppColors.primary : Colors.grey,
            size: 22,
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style:  TextStyle(
              color: isSelected ? AppColors.primary : Colors.grey,
              fontSize: 11,
            ),
          )
        ],
      ),
    );
  }
}
