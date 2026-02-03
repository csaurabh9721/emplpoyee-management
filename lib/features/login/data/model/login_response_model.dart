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
    required super.userId,
    required super.token,
  });

  factory Response.fromJson(Map<String, dynamic> json) => Response(
        userId: json["userid"],
        token: json["token"],
      );
}
