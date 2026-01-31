// import 'dart:convert';
// import 'package:http/http.dart' as http;
//
// import '../config/network_config.dart';
//
// class DeleteApiBase {
//
//   factory DeleteApiBase() => _instance;
//   DeleteApiBase._();
//
//   static final DeleteApiBase _instance = DeleteApiBase._();
//
//   http.Client client = http.Client();
//
//   Map<String, String> _header() {
//     return {
//       'Authorization': 'Bearer yourToken',
//       'Content-Type': 'application/json',
//     };
//   }
//
//   Future<Map<String, dynamic>> deleteApi({required String url}) async {
//     try {
//       final http.Response response = await client
//           .delete(NetworkConfig.getUrl(url), headers: _header())
//           .timeout(const Duration(seconds: 10));
//       return _getResponse(response);
//     } catch (e) {
//       throw Exception("Request Time out");
//     }
//   }
//
//   Map<String, dynamic> _getResponse(http.Response response) {
//     return jsonDecode(response.body);
//   }
// }
