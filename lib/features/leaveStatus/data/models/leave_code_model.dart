import '../../domain/entity/leave_code_entity.dart';

class LeaveCodeResponseModel {

  LeaveCodeResponseModel({
    required this.statusCode,
    required this.message,
    required this.entity,
  });

  factory LeaveCodeResponseModel.fromJson(Map<String, dynamic> json) => LeaveCodeResponseModel(
        statusCode: json["statuscode"],
        message: json["message"],
        entity: json["entity"] == null ? null : LeaveCodeModel.fromJson(json["entity"]),
      );
  final int statusCode;
  final String message;
  final LeaveCodeModel? entity;

  List<LeaveCode> toEntity() {
    return entity!.employeeTagLeaveList.map((e) => e.toEntity()).toList();
  }
}

class LeaveCodeModel {

  LeaveCodeModel({
    required this.employeeTagLeaveList,
  });

  factory LeaveCodeModel.fromJson(Map<String, dynamic> json) => LeaveCodeModel(
        employeeTagLeaveList: json["employeeTagLeaveList"] == null
            ? []
            : List<EmployeeTagLeaveList>.from(
                json["employeeTagLeaveList"].map((x) => EmployeeTagLeaveList.fromJson(x))),
      );
  final List<EmployeeTagLeaveList> employeeTagLeaveList;
}

class EmployeeTagLeaveList {

  EmployeeTagLeaveList({
    required this.leaveTypeId,
    required this.leaveCode,
  });

  factory EmployeeTagLeaveList.fromJson(Map<String, dynamic> json) => EmployeeTagLeaveList(
        leaveTypeId: json["leavetypeid"] ?? "",
        leaveCode: json["leavecode"] ?? "",
      );
  final String leaveTypeId;
  final String leaveCode;

  LeaveCode toEntity() {
    return LeaveCode(leaveTypeId: leaveTypeId, leaveCode: leaveCode);
  }
}
