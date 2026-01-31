import 'package:clientone_ess/features/leaveApproval/domain/entity/employee_leave_list.dart';

class EmployeeApprovalListModel {
  EmployeeApprovalListModel({
    required this.statusCode,
    required this.message,
    required this.entity,
  });

  factory EmployeeApprovalListModel.fromJson(Map<String, dynamic> json) =>
      EmployeeApprovalListModel(
        statusCode: json["statuscode"] ?? 400,
        message: json["message"] ?? "Failed to load data",
        entity: json["entity"] == null ? null : Entity.fromJson(json["entity"]),
      );
  final int statusCode;
  final String message;
  final Entity? entity;

  List<EmployeeLeaveList> toEntity() {
    return entity!.approvalList.map((e) => e.toEntity()).toList();
  }
}

class Entity {
  Entity({
    required this.approvalList,
  });

  factory Entity.fromJson(Map<String, dynamic> json) => Entity(
        approvalList: json["approvarList"] == null
            ? []
            : List<ApprovalList>.from(
                json["approvarList"].map((x) => ApprovalList.fromJson(x))),
      );
  final List<ApprovalList> approvalList;
}

class ApprovalList {
  ApprovalList({
    required this.leaveType,
    required this.endDate,
    required this.noOfDays,
    required this.employeeCode,
    required this.leaveApplicationNo,
    required this.startDate,
    required this.employeeId,
    required this.employeeName,
  });

  factory ApprovalList.fromJson(Map<String, dynamic> json) => ApprovalList(
        leaveType: json["leavetype"],
        endDate: json["enddate"],
        noOfDays: json["noofdays"],
        employeeCode: json["employeecode"],
        leaveApplicationNo: json["leaveapplicationno"],
        startDate: json["startdate"],
        employeeId: json["employeeid"],
        employeeName: json["employeename"],
      );
  final String leaveType;
  final String endDate;
  final String noOfDays;
  final String employeeCode;
  final String leaveApplicationNo;
  final String startDate;
  final String employeeId;
  final String employeeName;

  EmployeeLeaveList toEntity() {
    return EmployeeLeaveList(
      leaveType: leaveType,
      endDate: endDate,
      noOfDays: noOfDays,
      employeeCode: employeeCode,
      leaveApplicationNo: leaveApplicationNo,
      startDate: startDate,
      employeeId: employeeId,
      employeeName: employeeName,
    );
  }
}
