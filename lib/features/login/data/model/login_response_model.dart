import '../../domain/entity/login_response_entity.dart';

class LoginModel {
  LoginModel({
    required this.statusCode,
    required this.response,
    required this.message,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
        statusCode: json["statuscode"] ?? 400,
        response: json["entity"] != null ? Response.fromJson(json["entity"]) : null,
        message: json["message"] ?? "Something went wrong",
      );
  final int statusCode;
  final Response? response;
  final String message;
}

class Response extends LoginResponseEntity {
  Response({
    required super.payrollAreaCode,
    required super.payrollAreaId,
    required super.companyId,
    required super.payrollUniqueId,
    required super.userId,
    required super.employeeId,
    required super.placeOfPostingId,
    required super.employeeTypeId,
    required super.profitCentreId,
    required super.profitCentreCode,
    required super.token,
  });

  factory Response.fromJson(Map<String, dynamic> json) => Response(
        payrollAreaCode: json["payrollareacode"],
        payrollAreaId: json["payrollareaid"],
        companyId: json["companyid"],
        payrollUniqueId: json["payrolluniqueid"],
        userId: json["userid"],
        employeeId: json["employeeid"],
        placeOfPostingId: json["placeofpostingid"],
        employeeTypeId: json["employeetypeid"],
        profitCentreId: json["profitcentreid"],
        profitCentreCode: json["profitcentrecode"],
        token: json["token"],
      );
}
