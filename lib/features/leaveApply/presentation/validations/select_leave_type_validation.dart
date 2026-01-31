import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:clientone_ess/core/utils/string_extensions.dart';

import '../../../../core/utils/date_formatter.dart';
import '../../../../shared/components/snackbar.dart';
import '../../../../shared/constants/app_constant.dart';
import '../../domain/entities/continuous_paid_leave.dart';
import '../../domain/entities/leave_balance_entity.dart';
import '../cubits/continuousPaidLeaveCubit/continuous_paid_leave_cubit.dart';

class SelectLeaveTypeValidation {
  const SelectLeaveTypeValidation(this.context);
  final BuildContext context;

  ///validation for select leave type
  Future<bool> selectLeaveValidation(
      {required LeaveListEntity selectedLeave,
      required String noDays,
      required String date,
      required String period}) async {
    debugPrint(selectedLeave.toString());
    final double days = double.tryParse(noDays) ?? 0;
    if (noDays.isEmpty) {
      AppSnackBar.errorSnackBar(message: "Number of days required");
      return false;
    }
    if (selectedLeave.paidType.isEqual("P")) {
      // 2.A: More than maximum allowed
      if (days > selectedLeave.maximumLeave) {
        AppSnackBar.errorSnackBar(
          message:
              "The Days applied cannot be greater than ${selectedLeave.maximumLeave}",
        );
        return false;
      }

      // 2.B: Less than required (assuming exact match is required)
      if (days < selectedLeave.minimumLeave) {
        AppSnackBar.errorSnackBar(
          message:
              "The Days applied cannot be less than ${selectedLeave.minimumLeave}",
        );
        return false;
      }
    }
    if (strDateIsAfter(date, selectedLeave.nextCreditOn) &&
        selectedLeave.maintainBalance.isEqual("Y")) {
      debugPrint("$date   ${selectedLeave.nextCreditOn}");
      final bool res = await leaveTypeValidationDialog(
          "Leave year is not open. Still want to apply leave!");
      return res;
    }
    if (strDateIsAfter(AppConstant.dateOfJoining, date)) {
      AppSnackBar.errorSnackBar(
          message: "Leave Date should be less than date of joining");
      return false;
    }
    if (selectedLeave.leaveBalance == 0 &&
        selectedLeave.advanceLeave.isEqual("N") &&
        selectedLeave.maintainBalance.isEqual("Y")) {
      AppSnackBar.errorSnackBar(
          message: "Leave balance not available in this Leave Code");
      return false;
    }

    if (strDateIsAfter(selectedLeave.datePeriodFrom, date)) {
      AppSnackBar.errorSnackBar(
          message: "The Leave period is closed for applying leave.");
      return false;
    }
    context.read<ContinuousPaidLeaveCubit>().checkContinuousPaidLeave(
        ContinuousPaidLeaveEntity(
            fromDate: date,
            paidType: selectedLeave.paidType,
            startFromFHSH: period,
            leaveTypeId: selectedLeave.leaveTypeId,
            numberOfDaysApplied: noDays));
    return true;
  }

  Future<bool> leaveTypeValidationDialog(String message) async {
    return await showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext dialogContext) {
            return AlertDialog(
              content: Text(message),
              actions: <Widget>[
                TextButton(
                  child: const Text('Cancel'),
                  onPressed: () {
                    Navigator.of(dialogContext).pop(false);
                  },
                ),
                TextButton(
                  child: const Text('Confirm'),
                  onPressed: () {
                    Navigator.of(dialogContext).pop(true);
                  },
                ),
              ],
            );
          },
        ) ??
        false;
  }
}
