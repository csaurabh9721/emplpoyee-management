class ForgetPasswordRequest {
  final String email;
  final String employeeCode;

  ForgetPasswordRequest({
    required this.email,
    required this.employeeCode,
  });

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'employeeCode': employeeCode,
    };
  }
}

class ForgetPasswordResponse {
  final bool success;
  final String message;

  ForgetPasswordResponse({
    required this.success,
    required this.message,
  });

  factory ForgetPasswordResponse.fromJson(Map<String, dynamic> json) {
    return ForgetPasswordResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
    );
  }
}
