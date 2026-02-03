import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../config/network_config.dart';

class GetApiBase {
  GetApiBase._();

  static final GetApiBase _instance = GetApiBase._();

  static GetApiBase get instance => _instance;

  final http.Client _client = http.Client();

  /// 🔹 Persistent HTTP Client

  /// ✅ **Fetch Bearer Token dynamically**
  Future<String> _getAuthToken() async {
    return "";
  }

  /// ✅ **Generate dynamic headers**
  Future<Map<String, String>> _getHeaders({bool basicAuth = false}) async {
    return {
      'Authorization':"Bearer ${await _getAuthToken()}",
      'Content-Type': 'application/json',
    };
  }

  /// 🔹 **Reusable GET Request Handler**
  Future<Map<String, dynamic>> _makeGetRequest(
    String url, {
    bool basicAuth = false,
  }) async {
    final Map<String, String> headers = await _getHeaders(basicAuth: basicAuth);
    try {
      final response = await _client
          .get(NetworkConfig.getUrl(url), headers: headers)
          .timeout(const Duration(seconds: 20));
      return _handleResponse(response);
    } catch (e) {
      throw Exception("");
    }
  }

  /// 🔹 **GET Request**
  Future<Map<String, dynamic>> getApi({required String url}) {
    return _makeGetRequest(url);
  }


  /// 🔹 **Reusable Response Handler**
  Map<String, dynamic> _handleResponse(http.Response response) {
    return jsonDecode(response.body);
  }
}
