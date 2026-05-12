import 'package:clientone_ess/core/service/sessionManagement/sessions.dart';

class ChangePasswordRequest {
  final String oldPassword;
  final String newPassword;
  final String confirmPassword;

  ChangePasswordRequest({
    required this.oldPassword,
    required this.newPassword,
    required this.confirmPassword,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': Sessions.getUserId(),
      'oldPassword': oldPassword,
      'newPassword': newPassword,
      'confirmPassword': confirmPassword,
    };
  }
}

class ChangePasswordResponse {
  final int statusCode;
  final String message;
  final bool body;

  ChangePasswordResponse({
    required this.statusCode,
    required this.message,
    required this.body,
  });

  factory ChangePasswordResponse.fromJson(Map<String, dynamic> json) {
    return ChangePasswordResponse(
      statusCode: json['statusCode'] ?? false,
      message: json['message'] ?? '',
      body: json['body'] ?? '',
    );
  }
}
