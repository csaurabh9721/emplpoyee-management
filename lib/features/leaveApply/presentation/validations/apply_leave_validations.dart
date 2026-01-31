import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:clientone_ess/core/utils/string_extensions.dart';

import '../../../../core/Enums/enums.dart';
import '../../../../shared/components/snackbar.dart';
import '../../domain/entities/leave_balance_entity.dart';
import '../../domain/entities/save_leave_apply_entity.dart';
import '../../domain/entities/upload_file_entity.dart';
import '../cubits/change_leave_type_cubit.dart';
import '../cubits/leaveSaveCubit/leave_save_cubit.dart';
import '../cubits/start_period_cubit.dart';

class ApplyLeaveValidations {
  const ApplyLeaveValidations(this.context);
  final BuildContext context;

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

  /// Validates and applies for leave based on selected leave type and rules.
  Future<void> applyLeaveValidation({
    required String noDays,
    required String date,
    required String period,
    UploadedFileEntity? file,
    String? remark,
  }) async {
    final double days = double.tryParse(noDays) ?? 0;
    final selectedLeave =
        context.read<ChangeLeaveTypeCubit>().state.leaveBalance;
    // Condition 1.0: Leave type must be selected
    if (selectedLeave == null) {
      AppSnackBar.errorSnackBar(message: "Please Select Leave Type");
      return;
    }

    // Condition 2.0: If it's a Paid Leave
    if (selectedLeave.paidType.isEqual("P")) {
      // 2.A: More than maximum allowed
      if (days > selectedLeave.maximumLeave) {
        AppSnackBar.errorSnackBar(
          message:
              "The Days applied cannot be greater than ${selectedLeave.maximumLeave}",
        );
        return;
      }

      // 2.B: Less than required (assuming exact match is required)
      if (days < selectedLeave.minimumLeave) {
        AppSnackBar.errorSnackBar(
          message:
              "$days The Days applied cannot be less than ${selectedLeave.minimumLeave}",
        );
        return;
      }
    }

    // Condition 3.0: Exceeded max number of attempts
    if (selectedLeave.attemptedLeveCount > selectedLeave.noOfMaxAttempt) {
      AppSnackBar.errorSnackBar(
        message:
            "This leave cannot be applied more than ${selectedLeave.noOfMaxAttempt} times.",
      );
      return;
    }

    // Condition 4.0: Maintain balance is "Y" and balance is sufficient
    if (selectedLeave.maintainBalance.isEqual("Y") &&
        selectedLeave.leaveBalance >= days) {
      _applyLeave(selectedLeave, date, noDays, remark, file);
      return;
    }

    // Condition 5.0: Maintain balance is "Y" and balance is insufficient
    if (selectedLeave.maintainBalance.isEqual("Y") &&
        selectedLeave.leaveBalance < days) {
      if (selectedLeave.advanceLeave.isEqual("Y")) {
        // 5.A: Prompt for Advance Leave
        final bool res = await leaveTypeValidationDialog(
            "Do you want to apply advance leave ?");
        if (res) {
          // 5.A.1: Check if document required
          if (selectedLeave.documentRequired.isEqual("Y") && file == null) {
            AppSnackBar.errorSnackBar(message: "Attach Document for Leave !");
            return;
          }
          if (selectedLeave.documentRequired == "Y" &&
              file!.type != FilePickSource.pdf) {
            AppSnackBar.errorSnackBar(
                message:
                    "Wrong type of document attached, only PDF files allowed!");
            return;
          }
          _applyLeave(selectedLeave, date, noDays, remark, file);
          return;
        } else {
          // User cancelled advance leave
          _clearForm();
          return;
        }
      } else {
        // 5.B: Prompt for Leave Without Pay (LWP)
        final bool res =
            await leaveTypeValidationDialog("Do you want to apply LWP ?");
        if (res) {
          if (selectedLeave.documentRequired.isEqual("Y") && file == null) {
            AppSnackBar.errorSnackBar(message: "Attach Document for Leave !");
            return;
          }
          if (selectedLeave.documentRequired == "Y" &&
              file!.type != FilePickSource.pdf) {
            AppSnackBar.errorSnackBar(
                message:
                    "Wrong type of document attached, only PDF files allowed!");
            return;
          }
          _applyLeave(selectedLeave, date, noDays, remark, file);
          return;
        } else {
          // User cancelled LWP
          _clearForm();
          return;
        }
      }
    }

    // Condition 6.0: Maintain balance is "N" (No need to check balance)
    if (selectedLeave.maintainBalance.isEqual("N")) {
      if (selectedLeave.documentRequired.isEqual("Y") && file == null) {
        AppSnackBar.errorSnackBar(message: "Attach Document for Leave !");
        return;
      }

      if (selectedLeave.documentRequired == "Y" &&
          file!.type != FilePickSource.pdf) {
        AppSnackBar.errorSnackBar(
            message:
                "Wrong type of document attached, only PDF files allowed!");
        return;
      }

      _applyLeave(selectedLeave, date, noDays, remark, file);
      return;
    }
    // Fallback: Something went wrong
    AppSnackBar.errorSnackBar(message: "Failed to Apply Leave.");
  }

  /// Helper method to dispatch the ApplyLeaveEvent.
  void _applyLeave(LeaveListEntity selectedLeave, String date, String noDays,
      String? remark, UploadedFileEntity? uploadedFile) {
    final entity = SaveLeaveApplyEntity(
      date: date,
      leavePeriod: context.read<StartPeriodCubit>().selectedPeriod.name,
      noOfDays: noDays,
      leaveType: selectedLeave.leaveTypeCode,
      paidType: selectedLeave.paidType,
      leaveTypeId: selectedLeave.leaveTypeId,
      creditDays: selectedLeave.creditDays.toString(),
      availed: selectedLeave.availed.toString(),
      leaveBalance: selectedLeave.leaveBalance.toString(),
      advanceLeave: selectedLeave.advanceLeave.toString(),
      remark: remark,
      fileName: uploadedFile?.path.split("/").last,
    );
    context.read<LeaveSaveCubit>().applyLeave(entity, file: uploadedFile?.name);
  }

  /// Clear form if needed after cancellation
  void _clearForm() {
    context.read<ChangeLeaveTypeCubit>().changeLeveType(null);
  }
}
