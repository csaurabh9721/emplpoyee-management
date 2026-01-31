import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../../../main.dart';
import '../../../shared/components/snackbar.dart';
import '../../exceptions/api_exceptions.dart';
import '../../routes/routes_name.dart';
import '../../service/sessionManagement/sessions.dart';
import '../config/network_config.dart';

class PostApiBase {
  PostApiBase._();

  static final PostApiBase _instance = PostApiBase._();

  static PostApiBase get instance => _instance;

  final http.Client _client = http.Client();

  /// 🔹 Persistent HTTP Client

  /// ✅ **Fetch Bearer Token dynamically**
  String _getAuthToken() {
    return Sessions.getToken();
  }

  /// ✅ **Generate dynamic headers**
  Map<String, String> _getHeaders({bool basicAuth = false}) {
    return !basicAuth
        ? {
            'Authorization': "Bearer ${_getAuthToken()}",
            'Content-Type': 'application/json',
          }
        : {
            'Content-Type': 'application/json',
          };
  }

  /// 🔹 **Reusable GET Request Handler**
  Future<Map<String, dynamic>> _makeGetRequest(String url, {Map<String, dynamic>? body, bool basicAuth = false}) async {
    final Uri uri = NetworkConfig.getUrl(url);
    final Map<String, String> headers = _getHeaders(basicAuth: basicAuth);
    debugPrint("Header: $headers");
    debugPrint("Post Request: ${jsonEncode(body)}");
    try {
      final response = await _client
          .post(
            uri,
            headers: headers,
            body: body != null ? jsonEncode(body) : null,
          )
          .timeout(const Duration(seconds: 60));
      return _handleResponse(response);
    } catch (e) {
      log(e.toString());
      throw AppException("Unexpected error: Error in Post API: ${e.toString()}");
    }
  }

  Future<Map<String, dynamic>> post(
      {required String url, Map<String, dynamic>? body, bool isUseSecondUrl = false}) async {
    return _makeGetRequest(url, body: body);
  }

  Future<Map<String, dynamic>> postApiWithBasicAuth({required String url, required Map<String, dynamic> body}) async {
    return _makeGetRequest(url, body: body, basicAuth: true);
  }

  /// 🔹 **Reusable Response Handler**
  Map<String, dynamic> _handleResponse(http.Response response) {
    final int statusCode = response.statusCode;
    debugPrint("Response Code: $statusCode");
    log("Response Body: ${response.body}");
    if (statusCode == 200) {
      return jsonDecode(response.body);
    }
    if (statusCode == 401) {
      Sessions.erase();
      Navigator.pushNamedAndRemoveUntil(navigatorKey.currentContext!, RoutesName.login, (route) => false);
      AppSnackBar.infoSnackBar(message: "Session Expired.");
    }
    final errorMessages = {
      400: "Bad Request",
      //401: "Unauthorized - Token expired or missing",
      403: "Forbidden Access",
      404: "URL Not Found",
      405: "Method Not Allowed",
    };
    throw AppException(errorMessages[statusCode] ?? "Unexpected Error: ${response.body}");
  }
}
