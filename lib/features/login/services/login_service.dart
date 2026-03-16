import '../../../core/network/apiClients/get_api_base.dart';
import '../models/login_model.dart';

class LoginService {
  final GetApiBase _apiClient = GetApiBase.instance;

  Future<LoginResponse> login(LoginRequest request) async {
    await Future.delayed(const Duration(seconds: 2));
    try {
      // Simulate API call with dummy success response
      if (request.employeeId == 'EMP001' && request.password == 'password') {
        return LoginResponse(
          success: true,
          message: 'Login successful',
          token: 'dummy-jwt-token-12345',
          userData: {
            'employeeId': request.employeeId,
            'firstName': 'John',
            'lastName': 'Doe',
            'email': 'john.doe@company.com',
            'phone': '+1234567890',
            'department': 'IT',
            'position': 'Software Developer',
          },
        );
      } else {
        return LoginResponse(
          success: false,
          message: 'Invalid employee ID or password',
        );
      }
    } catch (e) {
      throw Exception('Login failed: $e');
    }
  }
}
