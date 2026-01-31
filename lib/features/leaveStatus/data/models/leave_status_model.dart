import '../../domain/entity/leave_status_entity.dart';

class LeaveStatusResponseModel {

  LeaveStatusResponseModel({
    required this.statusCode,
    required this.message,
    required this.leaveStatus,
  });

  factory LeaveStatusResponseModel.fromJson(Map<String, dynamic> json) => LeaveStatusResponseModel(
        statusCode: json["statuscode"]?.toString() ?? "400",
        message: json["message"] ?? "Something went wrong",
        leaveStatus: json["leavestatus"] == null
            ? []
            : List<LeaveStatusModel>.from(
                json["leavestatus"].map((x) => LeaveStatusModel.fromJson(x))),
      );
  final String statusCode;
  final String message;
  final List<LeaveStatusModel> leaveStatus;

  List<LeaveStatusEntity> toEntity() {
    return leaveStatus.map((e) => e.toEntity()).toList();
  }
}

class LeaveStatusModel {

  LeaveStatusModel({
    required this.leaveDescription,
    required this.reasonForLeave,
    required this.noOfDays,
    required this.leaveApplicationNo,
    required this.leaveStartDate,
    required this.leaveTypeCode,
    required this.currentApprovalNo,
    required this.approverName,
    required this.leaveEndDate,
    required this.remarks,
    required this.status,
  });

  factory LeaveStatusModel.fromJson(Map<String, dynamic> json) => LeaveStatusModel(
        leaveDescription: json["leavedescription"] ?? "",
        reasonForLeave: json["reasonforleave"] ?? "",
        noOfDays: json["noofdays"]?.toString() ?? "",
        leaveApplicationNo: json["leaveapplicationno"]?.toString() ?? "",
        leaveStartDate: json["leavestartdate"] ?? "",
        leaveTypeCode: json["leavetypecode"] ?? "",
        currentApprovalNo: json["currentapprovalno"]?.toString() ?? "",
        approverName: json["approvername"] ?? "",
        leaveEndDate: json["leaveenddate"] ?? "",
        remarks: json["remarks"] ?? "",
        status: json["status"] ?? "",
      );
  final String leaveDescription;
  final String reasonForLeave;
  final String noOfDays;
  final String leaveApplicationNo;
  final String leaveStartDate;
  final String leaveTypeCode;
  final String currentApprovalNo;
  final String approverName;
  final String leaveEndDate;
  final String remarks;
  final String status;

  LeaveStatusEntity toEntity() {
    return LeaveStatusEntity(
        leaveDescription: leaveDescription,
        reasonForLeave: reasonForLeave,
        noOfDays: noOfDays,
        leaveApplicationNo: leaveApplicationNo,
        leaveStartDate: leaveStartDate,
        leaveTypeCode: leaveTypeCode,
        currentApprovalNo: currentApprovalNo,
        approverName: approverName,
        leaveEndDate: leaveEndDate,
        remarks: remarks,
        status: status);
  }
}
