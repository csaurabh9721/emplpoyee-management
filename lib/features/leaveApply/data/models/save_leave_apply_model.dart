import 'package:clientone_ess/core/service/sessionManagement/sessions.dart';
import 'package:clientone_ess/core/utils/string_extensions.dart';

import '../../domain/entities/save_leave_apply_entity.dart';

class SaveLeaveApplyModel {
  SaveLeaveApplyModel(
      {required this.date,
      required this.leavePeriod,
      required this.noOfDays,
      required this.leaveType,
      required this.paidType,
      required this.leaveTypeId,
      required this.creditDays,
      required this.availed,
      required this.leaveBalance,
      required this.advanceLeave,
      this.remark,
      this.fileName});

  factory SaveLeaveApplyModel.copyWith(SaveLeaveApplyEntity entity) {
    return SaveLeaveApplyModel(
      date: entity.date,
      leavePeriod: entity.leavePeriod,
      noOfDays: entity.noOfDays,
      leaveType: entity.leaveType,
      paidType: entity.paidType,
      leaveTypeId: entity.leaveTypeId,
      creditDays: entity.creditDays,
      availed: entity.availed,
      leaveBalance: entity.leaveBalance,
      advanceLeave: entity.advanceLeave,
      remark: entity.remark,
      fileName: entity.fileName,
    );
  }
  final String date;
  final String leavePeriod;
  final String noOfDays;
  final String leaveType;
  final String paidType;
  final String leaveTypeId;
  final String creditDays;
  final String availed;
  final String leaveBalance;
  final String advanceLeave;
  final String? remark;
  final String? fileName;

  Map<String, String> toJson() {
    return {
      "employeecode": Sessions.getEmployeeCode(),
      "fromdate": date,
      "payrollareaid": Sessions.getPayrollAreaId(),
      "payrollareacode": Sessions.getPayrollAreaCode(),
      "payrolluniqueid": Sessions.getPayrollUniqueId(),
      "paidtype": paidType,
      "startfromfhsh": leavePeriod.firstLettersOfWords,
      "leavetypeid": leaveTypeId,
      "numberofdaysapplied": noOfDays,
      "leavetypecode": leaveType,
      "creditdays": creditDays,
      "aviled": availed,
      "leavebalance": leaveBalance,
      "advanceleave": advanceLeave,
      "filename": fileName ?? "",
      "fileuploadyn": fileName == null ? "N" : "Y",
      "leaveyear": date.split("/").last,
      "companyid": Sessions.getCompanyId(),
      "employeeid": Sessions.getEmployeeId(),
      "userid": Sessions.getUserId(),
      "remark": remark ?? "",
    };
  }
}
