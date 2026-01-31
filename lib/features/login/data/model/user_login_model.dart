class UserLoginModel {

  const UserLoginModel({required this.code, required this.password});
  final String code;
  final String password;

  Map<String, dynamic> toJson() {
    return {
      'loginid': code,
      'password': password,
    };
  }
}
