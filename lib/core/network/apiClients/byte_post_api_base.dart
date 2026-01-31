import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../../exceptions/api_exceptions.dart';
import '../../service/sessionManagement/sessions.dart';
import '../config/network_config.dart';

class BytePostApiBase {
  BytePostApiBase._();

  static final BytePostApiBase _instance = BytePostApiBase._();

  static BytePostApiBase get instance => _instance;

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
  Future<Uint8List> post({required String url, Map<String, dynamic>? body}) async {
    final Uri uri = NetworkConfig.getUrl(url);
    debugPrint("Post Request: $uri");
    debugPrint("Post Request: ${jsonEncode(body)}");
    try {
      final response = await _client
          .post(
            uri,
            headers: _getHeaders(),
            body: body != null ? jsonEncode(body) : null,
          )
          .timeout(const Duration(seconds: 20));
      return _handleResponse(response);
    } catch (e) {
      throw AppException(e.toString());
    }
  }

  /// 🔹 **Reusable Response Handler**
  Uint8List _handleResponse(http.Response response) {
    final int statusCode = response.statusCode;
    debugPrint("Response Code: $statusCode");
    debugPrint("Response Body: ${response.body}");
    if (statusCode == 200) {
      if (response.bodyBytes.isEmpty) {
        throw AppException("Failed to download file.");
      }
      return response.bodyBytes;
    }
    final errorMessages = {
      400: "Bad Request",
      401: "Unauthorized - Token expired or missing",
      403: "Forbidden Access",
      404: "URL Not Found",
      405: "Method Not Allowed",
    };
    throw AppException(errorMessages[statusCode] ?? "Unexpected Error: ${response.body}");
  }
}
