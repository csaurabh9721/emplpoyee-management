import 'package:clientone_ess/core/Enums/enums.dart';
import 'package:clientone_ess/shared/components/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../shared/app_color.dart';
import '../controllers/dashboard_controller.dart';
import '../models/dashboard_models.dart';

class DashboardScreen extends StatelessWidget {
  DashboardScreen({super.key});

  final DashboardController controller = Get.put(DashboardController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: GetBuilder<DashboardController>(
        builder: (_) {
          if (controller.dashboardData.status == ApiStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (controller.dashboardData.status == ApiStatus.error) {
            return Center(child: Text(controller.dashboardData.message));
          }

          final data = controller.dashboardData.data!;

          return Column(
            children: [
              /// 🔥 HEADER
              _HeaderSection(data: data),

              /// 🔥 BODY
              Expanded(
                child: RefreshIndicator(
                  onRefresh: controller.refreshDashboard,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        const _NextShiftCard(),
                        _QuickActionsSection(data: data.quickActions),
                        const _AnnouncementsSection(),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _HeaderSection extends StatelessWidget {
  final dynamic data;

  const _HeaderSection({required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 50, 20, 20),
      decoration: const BoxDecoration(
        gradient: AppColors.splashGradient,
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(30),
        ),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 28,
            backgroundImage: NetworkImage(data.image),
          ),
          const SizedBox(width: 12),

          /// Name + Designation
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  data.employeeName,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  data.designationName,
                  style: const TextStyle(color: Colors.white70),
                ),
              ],
            ),
          ),

          /// Notification Icon
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.notifications, color: Colors.white),
          )
        ],
      ),
    );
  }
}

class _NextShiftCard extends GetView<DashboardController> {
  const _NextShiftCard();

  @override
  Widget build(BuildContext context) {
    final DashboardDataModelBody data = controller.dashboardData.data!;

    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
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
                      data.todayAttendance.getFormattedDate,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.indigo,
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 10),
                Text(
                  "${data.todayAttendance.getFormattedPunchInTime} - ${data.todayAttendance.getFormattedPunchOutTime}",
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: data.todayAttendance.getContainerColor,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        data.todayAttendance.workHour,
                        style: const TextStyle(
                          fontSize: 15,
                        ),
                      ),
                    ),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Obx(() => controller.punchInOutLoading.value
                          ? const Center(
                              child: CircularProgressIndicator(),
                            )
                          : PrimaryIconButton(
                              onTap: controller.punchInOut,
                              icon: Icons.login,
                              label: data.todayAttendance.getButtonText,
                            )),
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

// class _QuickActions extends GetView<DashboardController> {
//   const _QuickActions();
//
//   @override
//   Widget build(BuildContext context) {
//     final DashboardDataModelBody data = controller.dashboardData.data!;
//
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const Text(
//           "Quick Actions",
//           style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//         ),
//         const SizedBox(height: 16),
//         GridView.builder(
//           shrinkWrap: true,
//           physics: const NeverScrollableScrollPhysics(),
//           itemCount: data.quickActions.length,
//           gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//             crossAxisCount: 3,
//             mainAxisSpacing: 10,
//             crossAxisSpacing: 10,
//             childAspectRatio: 0.85,
//           ),
//           itemBuilder: (context, index) {
//             final item = data.quickActions[index];
//             return _QuickActionItem(
//               icon: _getIconForAction(item.icon),
//               label: item.title,
//               color: _getColorForAction(item.icon),
//               onTap: () {
//                 if ("Attendance" == item.title) {
//                   Get.toNamed(item.route,
//                       arguments:
//                           controller.dashboardData.data!.todayAttendance);
//                 } else {
//                   Get.toNamed(item.route);
//                 }
//               },
//             );
//           },
//         )
//       ],
//     );
//   }
//
//   IconData _getIconForAction(String icon) {
//     switch (icon.toLowerCase()) {
//       case 'leave':
//         return Icons.event_busy;
//       case 'payslip':
//         return Icons.receipt_long;
//       case 'profile':
//         return Icons.person;
//       case 'attendance':
//         return Icons.calendar_month;
//       case 'approval':
//         return Icons.verified;
//       case 'holiday':
//         return Icons.holiday_village;
//       case 'balance':
//         return Icons.account_balance_wallet;
//       case 'team_attendance':
//         return Icons.group;
//       case 'account_balance':
//         return Icons.account_balance;
//       case 'account_detail':
//         return Icons.account_balance_wallet;
//       case 'leave_management':
//         return Icons.event_available;
//       case 'leave_approval':
//         return Icons.verified;
//
//       default:
//         return Icons.dashboard;
//     }
//   }
//
//   Color _getColorForAction(String icon) {
//     switch (icon.toLowerCase()) {
//       case 'leave':
//         return Colors.blue;
//       case 'payslip':
//         return Colors.green;
//       case 'profile':
//         return Colors.purple;
//       case 'attendance':
//         return Colors.orange;
//       case 'approval':
//         return Colors.teal;
//       case 'holiday':
//         return Colors.red;
//       case 'balance':
//         return Colors.indigo;
//       case 'team_attendance':
//         return Colors.pink;
//       case 'account_balance':
//         return Colors.indigo;
//       case 'account_detail':
//         return Colors.indigo;
//       case 'leave_management':
//         return Colors.blue;
//       case 'leave_approval':
//         return Colors.teal;
//       case 'leave_history':
//         return Colors.blue;
//
//       default:
//         return Colors.grey;
//     }
//   }
// }
// class _QuickActionItem extends StatelessWidget {
//   final IconData icon;
//   final String label;
//   final Color color;
//   final VoidCallback? onTap;
//
//   const _QuickActionItem({
//     required this.icon,
//     required this.label,
//     required this.color,
//     this.onTap,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: onTap,
//       borderRadius: BorderRadius.circular(35),
//       child: Column(
//         children: [
//           Container(
//             height: 70,
//             width: 70,
//             decoration: BoxDecoration(
//               color: color.withValues(alpha: 0.15),
//               shape: BoxShape.circle,
//             ),
//             child: Icon(icon, color: color),
//           ),
//           const SizedBox(height: 8),
//           Text(
//             label,
//             textAlign: TextAlign.center,
//             style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
//           ),
//         ],
//       ),
//     );
//   }
// }

class _QuickActionsSection extends StatelessWidget {
  final List<QuickActionModel> data;

  const _QuickActionsSection({required this.data});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12.0, 12, 12, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Quick Actions",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          SizedBox(
            height: 144,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: data.length,
              padding: const EdgeInsets.only(
                  top: 12, left: 12, right: 12, bottom: 14),
              itemBuilder: (context, index) {
                final QuickActionModel item = data[index];
                return _QuickActionCard(
                  title: item.title,
                  icon: _getIconForAction(item.icon),
                  color: _getColorForAction(item.icon),
                  onTap: () => Get.toNamed(item.route),
                );
              },
              separatorBuilder: (BuildContext context, int index) =>
                  const SizedBox(
                width: 16,
              ),
            ),
          ),
        ],
      ),
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
      case 'attendance':
        return Icons.calendar_month;
      case 'approval':
        return Icons.verified;
      case 'holiday':
        return Icons.holiday_village;
      case 'balance':
        return Icons.account_balance_wallet;
      case 'team_attendance':
        return Icons.group;
      case 'account_balance':
        return Icons.account_balance;
      case 'account_detail':
        return Icons.account_balance_wallet;
      case 'leave_management':
        return Icons.event_available;
      case 'leave_approval':
        return Icons.verified;

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
      case 'attendance':
        return Colors.orange;
      case 'approval':
        return Colors.teal;
      case 'holiday':
        return Colors.red;
      case 'balance':
        return Colors.indigo;
      case 'team_attendance':
        return Colors.pink;
      case 'account_balance':
        return Colors.indigo;
      case 'account_detail':
        return Colors.indigo;
      case 'leave_management':
        return Colors.blue;
      case 'leave_approval':
        return Colors.teal;
      case 'leave_history':
        return Colors.blue;

      default:
        return Colors.grey;
    }
  }
}

class _QuickActionCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const _QuickActionCard({
    required this.title,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 95,
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.15),
              blurRadius: 6,
              offset: const Offset(6, 6),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            /// Icon container
            Container(
              height: 44,
              width: 44,
              decoration: BoxDecoration(
                color: color.withOpacity(0.12),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: color, size: 22),
            ),

            const SizedBox(height: 10),

            /// Title
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: AppColors.textPrimary,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}

class _AnnouncementsSection extends GetView<DashboardController> {
  const _AnnouncementsSection();

  @override
  Widget build(BuildContext context) {
    final DashboardDataModelBody data = controller.dashboardData.data!;

    return Padding(
      padding: const EdgeInsets.fromLTRB(12.0, 4, 12, 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Announcements",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
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
          const SizedBox(height: 12),
          ...data.announcements.map((announcement) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: _AnnouncementCard(
                tag: announcement.type,
                title: announcement.title,
                description: announcement.description,
                image:
                    "https://images.unsplash.com/photo-${announcement.id == '1' ? '1521737604893-d14cc237f11d' : '1588776814546-ec7eae3b2b3d'}",
              ),
            );
          }),
        ],
      ),
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
                      valueColor:
                          AlwaysStoppedAnimation<Color>(Colors.grey.shade400),
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
