import 'package:clientone_ess/core/Enums/enums.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/dashboard_controller.dart';
import '../models/dashboard_models.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(DashboardController());

    return Scaffold(
      backgroundColor: const Color(0xFFF4F6FA),
      body: SafeArea(
        child: GetBuilder<DashboardController>(
                builder: (_) {
          if (controller.dashboardData.status == ApiStatus.loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (controller.dashboardData.status == ApiStatus.error) {
            return  Center(
              child: Text(controller.dashboardData.message),
            );
          }
          return RefreshIndicator(
            onRefresh: controller.refreshDashboard,
            child: const SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _HeaderSection(),
                  SizedBox(height: 24),
                  _NextShiftCard(),
                  SizedBox(height: 28),
                  _QuickActions(),
                  SizedBox(height: 28),
                  _AnnouncementsSection(),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}

class _HeaderSection extends GetView<DashboardController> {

  const _HeaderSection();


  @override
  Widget build(BuildContext context) {
    final DashboardDataModel data = controller.dashboardData.data!;
    return Row(
      children: [
        const CircleAvatar(
          radius: 28,
          backgroundImage: NetworkImage(
            "https://i.pravatar.cc/150?img=3",
          ),
        ),
        const SizedBox(width: 14),
        const Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                 "Employee",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 4),
              Text(
                "Senior Software Engineer",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.indigo,
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.indigo.shade50,
            shape: BoxShape.circle,
          ),
          child: const Icon(Icons.notifications, color: Colors.indigo),
        )
      ],
    );
  }
}

class _NextShiftCard extends GetView<DashboardController>  {

  const _NextShiftCard();

  @override
  Widget build(BuildContext context) {
    final DashboardDataModel data = controller.dashboardData.data!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 8,
                offset: Offset(0, 4),
              )
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(Icons.calendar_today, color: Colors.indigo),
                  const SizedBox(width: 8),
                  Text(
                    data.todayAttendance.date,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.indigo,
                    ),
                  )
                ],
              ),
              const SizedBox(height: 10),
              Text(
                data.todayAttendance.time,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.login),
                      label: const Text("Check In"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.indigo,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.indigo.shade50,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: const Icon(Icons.map, color: Colors.indigo),
                  )
                ],
              )
            ],
          ),
        )
      ],
    );
  }
}

class _QuickActions extends GetView<DashboardController>  {

  const _QuickActions();

  @override
  Widget build(BuildContext context) {
    final DashboardDataModel data = controller.dashboardData.data!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Quick Actions",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: data.quickActions.map((action) {
            return _QuickActionItem(
              icon: _getIconForAction(action.icon),
              label: action.title,
              color: _getColorForAction(action.icon),
              onTap: () => Get.toNamed(action.route),
            );
          }).toList(),
        )
      ],
    );
  }

  IconData _getIconForAction(String icon) {
    switch (icon.toLowerCase()) {
      case 'leave':
        return Icons.event_busy;
      case 'payslip':
        return Icons.receipt_long;
      case 'profile':
        return Icons.person;
      default:
        return Icons.dashboard;
    }
  }

  Color _getColorForAction(String icon) {
    switch (icon.toLowerCase()) {
      case 'leave':
        return Colors.blue;
      case 'payslip':
        return Colors.green;
      case 'profile':
        return Colors.purple;
      default:
        return Colors.grey;
    }
  }
}

class _QuickActionItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback? onTap;

  const _QuickActionItem({
    required this.icon,
    required this.label,
    required this.color,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(35),
      child: Column(
        children: [
          Container(
            height: 70,
            width: 70,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.15),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color),
          ),
          const SizedBox(height: 8),
          Text(label),
        ],
      ),
    );
  }
}

class _AnnouncementsSection extends GetView<DashboardController>  {
  const _AnnouncementsSection();

  @override
  Widget build(BuildContext context) {
    final DashboardDataModel data = controller.dashboardData.data!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Announcements",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(
              "See All",
              style: TextStyle(
                color: Colors.indigo,
                fontWeight: FontWeight.w500,
              ),
            )
          ],
        ),
        const SizedBox(height: 16),
        ...data.announcements.map((announcement) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: _AnnouncementCard(
              tag: announcement.type,
              title: announcement.title,
              description: announcement.description,
              image: "https://images.unsplash.com/photo-${announcement.id == '1' ? '1521737604893-d14cc237f11d' : '1588776814546-ec7eae3b2b3d'}",
            ),
          );
        }).toList(),
      ],
    );
  }
}

class _AnnouncementCard extends StatelessWidget {
  final String tag;
  final String title;
  final String description;
  final String image;

  const _AnnouncementCard({
    required this.tag,
    required this.title,
    required this.description,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
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
                Container(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.orange.shade100,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    tag,
                    style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.deepOrange),
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  title,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 6),
                Text(
                  description,
                  style: const TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(14),
            child: Image.network(
              image,
              height: 80,
              width: 80,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  height: 80,
                  width: 80,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Icon(
                    Icons.image_not_supported,
                    color: Colors.grey[400],
                    size: 32,
                  ),
                );
              },
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return Container(
                  height: 80,
                  width: 80,
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Center(
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.grey.shade400),
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}

