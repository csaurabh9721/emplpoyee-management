import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../shared/constants/app_constant.dart';
import '../../exceptions/api_exceptions.dart';
import '../../routes/routes_name.dart';
import '../../service/sessionManagement/sessions.dart';
import '../config/network_config.dart';

class PutApiBase {
  PutApiBase._();

  static final PutApiBase _instance = PutApiBase._();

  static PutApiBase get instance => _instance;

  final http.Client _client = http.Client();

  /// ✅ **Generate dynamic headers**
  Map<String, String> _getHeaders({bool basicAuth = false}) {
    return !basicAuth
        ? {
            'Authorization': "Bearer ${Sessions.getAccessToken()}",
            'Content-Type': 'application/json',
          }
        : {
            'Authorization': "Basic ${AppConstant.basicAuth}",
            'Content-Type': 'application/json',
          };
  }

  Future<Map<String, dynamic>> putApi({required String url, Map<String, dynamic>? body}) async {
    try {
      final Uri uri = NetworkConfig.getUrl(url);
      final Map<String, String> headers = _getHeaders();
      debugPrint("Header: $headers");
      debugPrint("Post Request: ${jsonEncode(body)}");
      final http.Response response = await http
          .put(
            uri,
            headers: headers,
            body: body != null ? jsonEncode(body) : null,
          )
          .timeout(const Duration(seconds: 10));
      return _handleResponse(response);
    } catch (e) {
      throw AppException("Request Time out");
    }
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
