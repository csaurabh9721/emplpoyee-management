import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:clientone_ess/core/routes/routes_name.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../exceptions/api_exceptions.dart';
import '../../service/sessionManagement/sessions.dart';
import '../config/network_config.dart';

class GetApiBase {
  GetApiBase._();

  static final GetApiBase _instance = GetApiBase._();

  static GetApiBase get instance => _instance;

  final http.Client _client = http.Client();

  /// 🔹 Persistent HTTP Client

  /// ✅ **Fetch Bearer Token dynamically**

  /// ✅ **Generate dynamic headers**
  Map<String, String> _getHeaders() {
    return {
      'Authorization': "Bearer ${Sessions.getAccessToken()}",
      'Content-Type': 'application/json',
    };
  }

  /// 🔹 **Reusable GET Request Handler**
  Future<Map<String, dynamic>> _makeGetRequest(String url) async {
    final Uri uri = NetworkConfig.getUrl(url);
    final Map<String, String> headers = _getHeaders();
    debugPrint("Header: $headers");
    try {
      final response = await _client.get(uri, headers: headers).timeout(const Duration(seconds: 20));
      return _handleResponse(response);
    } catch (e) {
      log(e.toString());
      throw AppException(e.toString());
    }
  }

  /// 🔹 **GET Request**
  Future<Map<String, dynamic>> getApi({required String url}) {
    return _makeGetRequest(url);
  }

  /// 🔹 **Reusable Response Handler**
  Map<String, dynamic> _handleResponse(http.Response response) {
    final int statusCode = response.statusCode;
    debugPrint("Response Code: $statusCode");
    log("Response Body: ${response.body}");
    final decodedData = jsonDecode(response.body);
    if (statusCode == 200) {
      return decodedData;
    }
    if (statusCode == 401) {
      Sessions.erase();
      Get.offAllNamed(RoutesName.login);
      throw AppException(decodedData["message"] ?? "Unauthorized - Token expired or missing");
    }

    final errorMessages = {
      400: decodedData["message"] ?? "Bad Request",
      401: decodedData["message"] ?? "Unauthorized - Token expired or missing",
      403: decodedData["message"] ?? "Forbidden Access",
      404: decodedData["message"] ?? "URL Not Found",
      405: decodedData["message"] ?? "Method Not Allowed",
    };
    throw AppException(errorMessages[statusCode] ?? "Unexpected Error: ${response.body}");
  }
}
