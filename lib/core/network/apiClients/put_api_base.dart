// import 'dart:async';
// import 'dart:convert';
// import 'package:flutter/cupertino.dart';
// import 'package:http/http.dart' as http;
//
// import '../../exceptions/api_exceptions.dart';
// import '../config/network_config.dart';
//
// class PutApiBase {
//
//   factory PutApiBase() => _instance;
//   PutApiBase._();
//
//   static final PutApiBase _instance = PutApiBase._();
//
//   Map<String, String> _header() {
//     return {
//       'Authorization': 'Bearer yourToken',
//       'Content-Type': 'application/json',
//     };
//   }
//
//   Future<Map<String, dynamic>?> putApi({required String url, Map<String, dynamic>? body}) async {
//     try {
//       final http.Response response = await http
//           .put(
//             NetworkConfig.getUrl(url),
//             headers: _header(),
//             body: body != null ? jsonEncode(body) : null,
//           )
//           .timeout(const Duration(seconds: 10));
//       debugPrint(response.body);
//       return _getResponse(response);
//     } catch (e) {
//       throw AppException("Request Time out");
//     }
//   }
//
//   Map<String, dynamic>? _getResponse(http.Response response) {
//     switch (response.statusCode) {
//       case 200:
//         return jsonDecode(response.body);
//       case 400:
//         throw AppException("Bad request found");
//       case 401:
//         throw AppException("Token expired or Token not found");
//       case 404:
//         throw AppException("Url Not Found");
//       default:
//         throw AppException(response.body.toString());
//     }
//   }
// }
