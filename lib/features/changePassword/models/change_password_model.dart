class ChangePasswordRequest {
  final int id;
  final String oldPassword;
  final String newPassword;
  final String confirmPassword;

  ChangePasswordRequest({
    required this.id,
    required this.oldPassword,
    required this.newPassword,
    required this.confirmPassword,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'oldPassword': oldPassword,
      'newPassword': newPassword,
      'confirmPassword': confirmPassword,
    };
  }
}

class ChangePasswordResponse {
  final int success;
  final String message;
  final bool body;

  ChangePasswordResponse({
    required this.success,
    required this.message,
    required this.body,
  });

  factory ChangePasswordResponse.fromJson(Map<String, dynamic> json) {
    return ChangePasswordResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      body: json['body'] ?? '',
    );
  }
}
