import '../../domain/entity/employee_list_entity.dart';

class EmployeeListModelForApproval {

  EmployeeListModelForApproval({
    required this.statusCode,
    required this.message,
    required this.entity,
  });

  factory EmployeeListModelForApproval.fromJson(Map<String, dynamic> json) => EmployeeListModelForApproval(
        statusCode: json["statuscode"] ?? 400,
        message: json["message"] ?? "Failed to fetch employees.",
        entity: json["entity"] != null ? Entity.fromJson(json["entity"]) : null,
      );
  final int statusCode;
  final String message;
  final Entity? entity;

  List<EmployeeListEntity> dtoToEntity() {
    return entity!.approvalList.map((e) => e.dtoToEntity()).toList() ;
  }
}

class Entity {

  Entity({
    required this.approvalList,
  });

  factory Entity.fromJson(Map<String, dynamic> json) => Entity(
        approvalList: json["approvarList"] == null
            ? []
            : List<ApprovalList>.from(json["approvarList"].map((x) => ApprovalList.fromJson(x))),
      );
  final List<ApprovalList> approvalList;
}

class ApprovalList {

  ApprovalList({
    required this.employeeCode,
    required this.employeeId,
    required this.employeeName,
  });

  factory ApprovalList.fromJson(Map<String, dynamic> json) => ApprovalList(
        employeeCode: json["employeecode"] ?? "",
        employeeId: json["employeeid"] ?? "",
        employeeName: json["employeename"] ?? "",
      );
  final String employeeCode;
  final String employeeId;
  final String employeeName;

  EmployeeListEntity dtoToEntity() {
    return EmployeeListEntity(
      employeeCode: employeeCode,
      employeeId: employeeId,
      employeeName: employeeName,
    );
  }
}
