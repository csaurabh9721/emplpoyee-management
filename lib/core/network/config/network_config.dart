import 'package:flutter/foundation.dart';

class NetworkConfig {
  static const String baseUrl = "";

  static Uri getUrl(String url) {
    final String fullUrl = baseUrl + url;
    final Uri uri = Uri.parse(fullUrl);
    debugPrint(uri.toString());
    return uri;
  }
}
