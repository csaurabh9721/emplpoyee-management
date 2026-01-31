import '../../domain/entities/apply_leave_response_entity.dart';

class ApplyLeaveResponseModel {

  ApplyLeaveResponseModel({required this.statusCode, required this.message, required this.entity});

  factory ApplyLeaveResponseModel.fromJson(Map<String, dynamic> json) {
    return ApplyLeaveResponseModel(
        statusCode: json['statuscode'] ?? 400,
        message: json['message'] ?? "Something went wrong.",
        entity: json['entity'] != null
            ? ApplyLeaveModel.fromJson(json['entity'])
            : ApplyLeaveModel(success: false, message: "Something went wrong."));
  }
  final int statusCode;
  final String message;
  final ApplyLeaveModel entity;

  ApplyLeaveResponseEntity dtoToEntity(){
    return ApplyLeaveResponseEntity(
        success: entity.success,
        message: entity.message
    );
  }
}

class ApplyLeaveModel {

  ApplyLeaveModel({required this.success, required this.message});

  factory ApplyLeaveModel.fromJson(Map<String, dynamic> json) {
    return ApplyLeaveModel(
        success: json['success'] ?? false, message: json['message'] ?? "Filed to apply leave.");
  }
  final bool success;
  final String message;
}
