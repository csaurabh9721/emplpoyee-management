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

class PostApiBase {
  PostApiBase._();

  static final PostApiBase _instance = PostApiBase._();

  static PostApiBase get instance => _instance;

  final http.Client _client = http.Client();

  /// 🔹 Persistent HTTP Client


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
      throw AppException(e.toString());
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
    final decodedData = jsonDecode(response.body);
    if (statusCode == 200 || statusCode == 201) {
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
