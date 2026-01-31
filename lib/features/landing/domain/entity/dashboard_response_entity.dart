import 'dart:ui';

import '../../../../core/routes/routes_name.dart';
import '../../../../core/utils/rights_ids.dart';
import '../../../../shared/app_color.dart';

class DashboardResponseEntity {

  DashboardResponseEntity({
    required this.leaveBalance,
    required this.todayStatus,
    required this.latestPayslip,
    required this.rights,
  });
  final DashboardLeaveBalanceEntity leaveBalance;
  final TodayStatusEntity todayStatus;
  final LatestPayslipEntity latestPayslip;
  final List<RightEntity> rights;

  bool get isLeaveApplyActive => _rightIds.contains(RightsIds.leaveApply);

  bool get isAttendanceActive => _rightIds.contains(RightsIds.attendance);

  bool get isPaySlipActive => _rightIds.contains(RightsIds.paySlip);

  bool get isLeaveBalanceActive => _rightIds.contains(RightsIds.leaveBalance);

  bool get isLeaveWithdrawActive => _rightIds.contains(RightsIds.leaveWithdraw);

  bool get isLeaveHistoryActive => _rightIds.contains(RightsIds.leaveApply);//depend on leave apply

  bool get isLeaveApprovalActive => _rightIds.contains(RightsIds.leaveApproval);

  bool get isLeaveStatusActive => _rightIds.contains(RightsIds.leaveStatus);

  bool get isLeaveLedgerActive => _rightIds.contains(RightsIds.leaveLedger);

  bool get isAccountBalanceActive => _rightIds.contains(RightsIds.accountBalance);

  bool get isAccountLedgerActive => _rightIds.contains(RightsIds.accountLedger);

  bool get isTeamPunchActive => _rightIds.contains(RightsIds.teamPunch);

  bool get isAttendanceSummaryActive => _rightIds.contains(RightsIds.attendanceSummary);

  late final Set<String> _rightIds = rights.map((e) => e.rightsId).toSet();

  bool get isQuickAccess => isAccountBalanceActive || isAccountLedgerActive || isTeamPunchActive;

  List<AppDashboardRoutes> get getRightForDrawer {
    final List<AppDashboardRoutes> list = [];
    for (RightEntity i in rights) {
      if (RightsIds.routeMap.containsKey(i.rightsId)) {
        list.add(RightsIds.routeMap[i.rightsId]!);
        if (i.rightsId == RightsIds.leaveApply) {
          list.add(AppDashboardRoutes(route: RoutesName.leaveHistory, name: "Leave History"));
        }
      }
    }

    list.sort((a, b) => a.name.compareTo(b.name));
    return list;
  }
}

class LatestPayslipEntity {

  LatestPayslipEntity({
    required this.status,
    required this.date,
  });
  final String status;
  final String date;
}

class DashboardLeaveBalanceEntity {

  DashboardLeaveBalanceEntity({
    required this.cl,
    required this.el,
    required this.pending,
    this.ccl,
  });
  final String cl;
  final String el;
  final String pending;
  final String? ccl;

  String get leaveBalance {
    final String formattedEl = el.endsWith(".00") ? el.substring(0, el.length - 3) : el;
    final String formattedCl = cl.endsWith(".00") ? cl.substring(0, cl.length - 3) : cl;
    final String? formattedCcl = ccl?.endsWith(".00") == true ? ccl!.substring(0, ccl!.length - 3) : ccl;
    return formattedCcl ?? "$formattedCl/$formattedEl";
  }

  String get leaveBalanceType {
    return ccl != null ? "CCL" : "CL/EL";
  }
}

class RightEntity {

  RightEntity({
    required this.rightsName,
    required this.rightsId,
    required this.seqId,
  });
  final String rightsName;
  final String rightsId;
  final int seqId;
}

class AppDashboardRoutes {

  AppDashboardRoutes({required this.route, required this.name});
  final String route;
  final String name;
}

class TodayStatusEntity {

  TodayStatusEntity({
    required this.status,
    required this.time,
  });
  final String status;
  final String time;

  String get arrivalStatus {
    try {
      final List<String> parts = time.split(" ");
      final List<String> times = parts[0].split(":");
      final int hour = int.parse(times[0]);
      final int minute = int.parse(times[1]);
      if (hour == 9 && minute < 31) {
        return "On Time";
      } else if (hour == 9 && minute < 46) {
        return "Late";
      } else {
        return "Penalty";
      }
    } catch (e) {
      return "";
    }
  }

  Color get arrivalStatusColor {
    try {
      final List<String> parts = time.split(" ");
      final List<String> times = parts[0].split(":");
      final int hour = int.parse(times[0]);
      final int minute = int.parse(times[1]);
      if (hour == 8 || hour == 9 && minute < 31) {
        return AppColors.green;
      } else if (hour == 9 && minute < 46) {
        return const Color(0xFFF9A825);
      } else if (hour == 9 && minute <= 59) {
        return AppColors.leaveWithdraw;
      } else {
        return AppColors.error;
      }
    } catch (e) {
      return AppColors.snackbarBackground;
    }
  }
}
