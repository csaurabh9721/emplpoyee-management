import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:clientone_ess/core/routes/routes_name.dart';
import 'package:clientone_ess/features/landing/presentation/bloc/landing_bloc.dart';
import 'package:clientone_ess/shared/app_color.dart';
import 'package:clientone_ess/shared/constants/png_images.dart';

import '../../domain/entity/dashboard_response_entity.dart';
import '../../domain/entity/profile_entity.dart';

class DashboardView extends StatelessWidget {
  const DashboardView(
      {super.key, required this.dashboardData, required this.profileData});
  final DashboardResponseEntity dashboardData;
  final ProfileResponseEntity profileData;

  @override
  Widget build(BuildContext context) {
    final double spacing = 12;
    final double horizontalPadding = 10;
    final double width = MediaQuery.of(context).size.width;
    return RefreshIndicator(
      onRefresh: () async {
        context.read<LandingBloc>().add(const RefreshDashboard());
      },
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Profile Section
            InkWell(
              onTap: () {
                context
                    .read<LandingBloc>()
                    .add(const LandingPageChangeEvent(1));
              },
              child: Card(
                margin: EdgeInsets.zero,
                elevation: 1,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0)),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundImage:
                            profileData.personalDetails.profileImage.isNotEmpty
                                ? MemoryImage(
                                    profileData.personalDetails.bytes,
                                  )
                                : null,
                        child: profileData.personalDetails.profileImage.isEmpty
                            ? const Icon(
                                Icons.person,
                                size: 36,
                              )
                            : null,
                      ),
                      const SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(profileData.personalDetails.name,
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold)),
                          Text(profileData.personalDetails.designation,
                              style: const TextStyle(color: Colors.grey)),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: spacing),

            /// Top Buttons Row
            Padding(
              padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
              child: Row(
                spacing: 8,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  if (dashboardData.isLeaveApplyActive)
                    _topButton(
                        text: "Leave Apply",
                        icon: Icons.add,
                        color: AppColors.darkBlue,
                        onPressed: () {
                          Navigator.pushNamed(context, RoutesName.leaveApply);
                        }),
                  if (dashboardData.isAttendanceActive)
                    _topButton(
                        text: "Attendance",
                        icon: Icons.watch_later,
                        color: AppColors.green,
                        onPressed: () {
                          Navigator.pushNamed(
                              context, RoutesName.attendancePunches);
                        }),
                  if (dashboardData.isPaySlipActive)
                    _topButton(
                        text: "Payslip",
                        icon: Icons.receipt_long,
                        color: AppColors.lightBlue1,
                        onPressed: () {
                          Navigator.pushNamed(context, RoutesName.payslip);
                        }),
                ],
              ),
            ),

            SizedBox(height: spacing),

            /// Info Boxes
            Padding(
              padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
              child: Row(
                children: [
                  _infoCard(
                      "Leave Balance",
                      dashboardData.leaveBalance.leaveBalance,
                      dashboardData.leaveBalance.leaveBalanceType),
                  const SizedBox(width: 10),
                  _infoCard(
                      "Today's Status",
                      dashboardData.todayStatus.status,
                      "${dashboardData.todayStatus.arrivalStatus} - ${dashboardData.todayStatus.time}",
                      dashboardData.todayStatus.arrivalStatusColor),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
              child: Row(
                children: [
                  _infoCard(
                      "Pending Approvals",
                      dashboardData.leaveBalance.pending.toString(),
                      "Leave Request"),
                  const SizedBox(width: 10),
                  _infoCard("Latest Payslip", dashboardData.latestPayslip.date,
                      dashboardData.latestPayslip.status),
                ],
              ),
            ),
            SizedBox(height: spacing),
            _label(horizontalPadding, context, "Manage Leave"),
            const SizedBox(height: 8),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 8,
                children: [
                  Expanded(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 8,
                    children: [
                      if (dashboardData.isLeaveBalanceActive)
                        _gridButton("Leave Balance", Icons.calendar_month,
                            AppColors.leaveBalance, 170, onTap: () {
                          Navigator.pushNamed(context, RoutesName.leaveBalance);
                        }),
                      if (dashboardData.isLeaveHistoryActive)
                        _gridButton("Leave History", Icons.calendar_month,
                            AppColors.leaveHistory, 100, onTap: () {
                          Navigator.pushNamed(context, RoutesName.leaveHistory);
                        }),
                      if (dashboardData.isLeaveStatusActive)
                        _gridButton("Leave Status", Icons.watch_later,
                            AppColors.leaveStatus, 80, onTap: () {
                          Navigator.pushNamed(context, RoutesName.leaveStatus);
                        }),
                    ],
                  )),
                  Expanded(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 8,
                    children: [
                      if (dashboardData.isLeaveWithdrawActive)
                        _gridButton(
                            "Leave Withdraw",
                            Icons.account_balance_wallet,
                            AppColors.leaveWithdraw,
                            100, onTap: () {
                          Navigator.pushNamed(
                              context, RoutesName.leaveWithdrawal);
                        }),
                      if (dashboardData.isLeaveLedgerActive)
                        _gridButton("Leave Ledger", Icons.history,
                            AppColors.leaveLedger, 170, onTap: () {
                          Navigator.pushNamed(context, RoutesName.leaveLedger);
                        }),
                      if (dashboardData.isLeaveApprovalActive)
                        _gridButton("Leave Approval", Icons.file_copy,
                            AppColors.leaveApproval, 80, onTap: () {
                          Navigator.pushNamed(
                              context, RoutesName.leaveApproval);
                        }),
                    ],
                  )),
                ],
              ),
            ),

            SizedBox(height: spacing),

            if (dashboardData.isQuickAccess)
              _label(horizontalPadding, context, "Quick Access"),
            const SizedBox(height: 8),

            /// Quick Access Buttons
            Padding(
              padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
              child: Row(
                spacing: 30,
                children: [
                  if (dashboardData.isAccountBalanceActive)
                    _quickAccess(
                        "Account Balance", Icons.account_balance_wallet, width,
                        onTap: () {
                      Navigator.pushNamed(context, RoutesName.accountBalance);
                    }),
                  if (dashboardData.isAccountLedgerActive)
                    _quickAccess("Account Ledger", Icons.receipt, width,
                        onTap: () {
                      Navigator.pushNamed(context, RoutesName.accountLedger);
                    }),
                ],
              ),
            ),
            const SizedBox(height: 12),
            if (dashboardData.isTeamPunchActive)
              Align(
                  alignment: Alignment.center,
                  child: _quickAccess("Team Attendance", Icons.group, width,
                      onTap: () {
                    Navigator.pushNamed(context, RoutesName.teamAttendance);
                  })),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Padding _label(double horizontalPadding, BuildContext context, String title) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
      child: Text(title,
          style: Theme.of(context)
              .textTheme
              .titleMedium!
              .copyWith(fontWeight: FontWeight.w900)),
    );
  }

  Widget _topButton({
    required String text,
    required IconData icon,
    required Color color,
    required VoidCallback onPressed,
  }) {
    return Expanded(
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: Icon(
          icon,
          size: 25,
        ),
        label: Text(text),
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          padding: const EdgeInsets.symmetric(vertical: 12),
          textStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
        ),
      ),
    );
  }

  Widget _infoCard(String title, String subtitle, String trailing,
      [Color? color]) {
    return Expanded(
      child: Card(
        margin: EdgeInsets.zero,
        elevation: 1,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 15)),
              Text(subtitle,
                  style: TextStyle(
                      color: color ?? AppColors.snackbarBackground,
                      fontWeight: FontWeight.bold,
                      fontSize: 18)),
              Text(trailing,
                  style: const TextStyle(
                      color: AppColors.snackbarBackground, fontSize: 13)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _gridButton(String title, IconData icon, Color color, double height,
      {required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: height,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: AppColors.white, size: 32),
            const SizedBox(height: 10),
            Text(title,
                style: const TextStyle(
                    color: AppColors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16),
                textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }

  Widget _quickAccess(String title, IconData icon, double width,
      {required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: SizedBox(
          height: 130,
          width: width / 2 - 27,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                height: 130,
                width: width / 2 - 27,
                color: AppColors.white,
              ),
              if (title == "Account Ledger")
                Positioned(
                    top: 0, right: 0, child: Image.asset(PngImages.polygon1)),
              if (title == "Account Ledger")
                Positioned(
                    top: -12, right: 0, child: Image.asset(PngImages.polygon2)),
              if (title == "Team Attendance")
                Positioned(
                    bottom: -10,
                    left: 0,
                    child: Image.asset(PngImages.polygon4)),
              if (title == "Team Attendance")
                Positioned(
                    bottom: -10,
                    left: 0,
                    child: Image.asset(PngImages.polygon3)),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircleAvatar(
                    backgroundColor: AppColors.darkBlue,
                    radius: 26,
                    child: Icon(icon, color: Colors.white),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    title,
                    style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: AppColors.snackbarBackground),
                    textAlign: TextAlign.center,
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
