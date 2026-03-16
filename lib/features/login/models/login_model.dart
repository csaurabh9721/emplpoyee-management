class LoginRequest {
  final String employeeId;
  final String password;

  LoginRequest({
    required this.employeeId,
    required this.password,
  });

  Map<String, dynamic> toJson() {
    return {
      'employeeId': employeeId,
      'password': password,
    };
  }
}

class LoginResponse {
  final bool success;
  final String message;
  final String? token;
  final Map<String, dynamic>? userData;

  LoginResponse({
    required this.success,
    required this.message,
    this.token,
    this.userData,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      token: json['token'],
      userData: json['userData'],
    );
  }
}
