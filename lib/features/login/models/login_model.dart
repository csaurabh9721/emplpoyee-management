class LoginRequest {
  final String emailId;
  final String password;

  LoginRequest({
    required this.emailId,
    required this.password,
  });

  Map<String, dynamic> toJson() {
    return {
      'emailId': emailId,
      'password': password,
    };
  }
}

class LoginResponse {
  final int statusCode;
  final String message;
  final LoginResponseBody? body;

  LoginResponse({
    required this.statusCode,
    required this.message,
    required this.body,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      statusCode: json['statusCode'] ?? 400,
      message: json['message'] ?? 'Something went wrong',
      body: json['body'] == null ? null : LoginResponseBody.fromJson(json['body']),
    );
  }

  @override
  String toString() {
    return 'LoginResponse{statusCode: $statusCode, message: $message, body: $body}';
  }
}

class LoginResponseBody {
  final int userId;
  final String employeeName;
  final String employeeCode;
  final String accessToken;
  final String refreshToken;

  const LoginResponseBody({
    required this.userId,
    required this.employeeName,
    required this.employeeCode,
    required this.accessToken,
    required this.refreshToken,
  });

  factory LoginResponseBody.fromJson(Map<String, dynamic> json) {
    return LoginResponseBody(
      userId: json['userId'] ?? 0,
      employeeName: json['employeeName'] ?? '',
      employeeCode: json['employeeCode'] ?? '',
      accessToken: json['accessToken'] ?? '',
      refreshToken: json['refreshToken'] ?? '',
    );
  }

  @override
  String toString() {
    return 'LoginResponseBody{userId: $userId, employeeName: $employeeName, employeeCode: $employeeCode, accessToken: $accessToken, refreshToken: $refreshToken}';
  }
}
