import 'package:flutter/cupertino.dart';

class EmployeeLeaveList {

  EmployeeLeaveList({
    required this.leaveType,
    required this.endDate,
    required this.noOfDays,
    required this.employeeCode,
    required this.leaveApplicationNo,
    required this.startDate,
    required this.employeeId,
    required this.employeeName,
  });
  final String leaveType;
  final String endDate;
  final String noOfDays;
  final String employeeCode;
  final String leaveApplicationNo;
  final String startDate;
  final String employeeId;
  final String employeeName;
  final TextEditingController remarkController = TextEditingController();
}