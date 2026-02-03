import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:clientone_ess/core/routes/routes_name.dart';
import 'package:clientone_ess/features/landing/presentation/bloc/landing_bloc.dart';
import 'package:clientone_ess/shared/app_color.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({super.key});

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  /// 🔑 TEMP STATE (later move to Bloc)
  bool isCheckedIn = false;
  DateTime? checkInTime;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        context.read<LandingBloc>().add(const RefreshDashboard());
      },
      child: Scaffold(
        backgroundColor: const Color(0xFFF6F7FB),
        body: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const _ProfileCard(),
              const SizedBox(height: 12),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(.08),
                      blurRadius: 18,
                    )
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                             Text(isCheckedIn ? "Checked In": "Today",
                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                            const SizedBox(height: 6),
                            Text(
                              isCheckedIn
                                  ? _formatTime(checkInTime!)
                                  : "Not Checked In",
                              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        const Spacer(),
                        ElevatedButton.icon(
                          onPressed: _handleAttendance,
                          icon: Icon(isCheckedIn ? Icons.logout : Icons.login),
                          label: Text(
                            isCheckedIn ? "Out" : "In",
                            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                            isCheckedIn ? Colors.redAccent : AppColors.green,
                            shape:
                            RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 12),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(6),
                      child: LinearProgressIndicator(
                        value: isCheckedIn ? 0.6 : 0,
                        minHeight: 6,
                        backgroundColor: Colors.grey.shade200,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      isCheckedIn ? "Working in progress" : "Tap Check In to start",
                      style: const TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              const _InsightsRow(),
              const SizedBox(height: 24),
              const _SectionTitle(title: "Manage Leave"),
              const SizedBox(height: 12),
              const _LeaveGrid(),
              const SizedBox(height: 24),
              const _SectionTitle(title: "Quick Access"),
              const SizedBox(height: 12),
              const _QuickAccessGrid(),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  /* -------------------------------------------------------------------------- */
  /*                         CHECK-IN / CHECK-OUT LOGIC                          */
  /* -------------------------------------------------------------------------- */
  static String _formatTime(DateTime time) {
    final hour = time.hour % 12 == 0 ? 12 : time.hour % 12;
    final minute = time.minute.toString().padLeft(2, '0');
    final period = time.hour >= 12 ? 'PM' : 'AM';
    return "$hour:$minute $period";
  }
  void _handleAttendance() {
    setState(() {
      if (!isCheckedIn) {
        // ✅ CHECK IN
        isCheckedIn = true;
        checkInTime = DateTime.now();
      } else {
        // ✅ CHECK OUT
        isCheckedIn = false;
        checkInTime = null;
      }
    });

    // 🔐 Later:
    // context.read<AttendanceBloc>().add(CheckInEvent());
    // context.read<AttendanceBloc>().add(CheckOutEvent());
  }
}

/* -------------------------------------------------------------------------- */
/*                                PROFILE CARD                                */
/* -------------------------------------------------------------------------- */

class _ProfileCard extends StatelessWidget {
  const _ProfileCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        gradient: LinearGradient(
          colors: [
            AppColors.darkBlue.withOpacity(.95),
            AppColors.lightBlue1.withOpacity(.95),
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.15),
            blurRadius: 16,
            offset: const Offset(0, 6),
          )
        ],
      ),
      child: InkWell(
        onTap: () {
        },
        child: const Row(
          children: [
            CircleAvatar(
              radius: 28,
              backgroundColor: Colors.white,
              child: Icon(Icons.person, size: 30, color: AppColors.darkBlue),
            ),
            SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Saurabh Chauhan",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  "Flutter Developer",
                  style: TextStyle(color: Colors.white70),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class _InsightsRow extends StatelessWidget {
  const _InsightsRow();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          _InsightCard("Leave Balance", "4", Icons.calendar_month),
          SizedBox(width: 12),
          _InsightCard("Late Days", "1", Icons.watch_later),
        ],
      ),
    );
  }
}

class _InsightCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;

  const _InsightCard(this.title, this.value, this.icon);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.06),
              blurRadius: 14,
            )
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: AppColors.darkBlue),
            const SizedBox(height: 8),
            Text(value,
                style:
                const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            Text(title,
                style: const TextStyle(color: Colors.grey, fontSize: 12)),
          ],
        ),
      ),
    );
  }
}

class _LeaveGrid extends StatelessWidget {
  const _LeaveGrid();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: GridView.count(
        crossAxisCount: 2,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        childAspectRatio: 1.6,
        children: [
          _GridItem("Leave Balance", Icons.calendar_month,
                  () => Navigator.pushNamed(context, RoutesName.leaveBalance)),
          _GridItem("Leave History", Icons.history,
                  () => Navigator.pushNamed(context, RoutesName.leaveHistory)),
          _GridItem("Leave Status", Icons.watch_later,
                  () => Navigator.pushNamed(context, RoutesName.leaveStatus)),
          _GridItem("Leave Ledger", Icons.receipt,
                  () => Navigator.pushNamed(context, RoutesName.leaveLedger)),
        ],
      ),
    );
  }
}

class _GridItem extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;

  const _GridItem(this.title, this.icon, this.onTap);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.05),
              blurRadius: 10,
            )
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: AppColors.darkBlue),
            const SizedBox(height: 10),
            Text(title,
                style:
                const TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
          ],
        ),
      ),
    );
  }
}

class _QuickAccessGrid extends StatelessWidget {
  const _QuickAccessGrid();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          _QuickAccessCard(
            "Account Balance",
            Icons.account_balance_wallet,
                () => Navigator.pushNamed(context, RoutesName.accountBalance),
          ),
          const SizedBox(width: 12),
          _QuickAccessCard(
            "Team Attendance",
            Icons.group,
                () => Navigator.pushNamed(context, RoutesName.teamAttendance),
          ),
        ],
      ),
    );
  }
}

class _QuickAccessCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;

  const _QuickAccessCard(this.title, this.icon, this.onTap);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Container(
          height: 130,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(.06),
                blurRadius: 14,
              )
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                backgroundColor: AppColors.darkBlue.withOpacity(.1),
                radius: 26,
                child: Icon(icon, color: AppColors.darkBlue),
              ),
              const SizedBox(height: 10),
              Text(title,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 14)),
            ],
          ),
        ),
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;

  const _SectionTitle({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Text(
        title,
        style: Theme.of(context)
            .textTheme
            .titleMedium!
            .copyWith(fontWeight: FontWeight.w800),
      ),
    );
  }
}
