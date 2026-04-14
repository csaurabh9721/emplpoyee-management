import 'dart:convert';

import 'package:flutter/material.dart';

class AppConstant {
  static const String basicUser = 'appdevix';
  static const String basicPassword = '123appdevix456';
  static  String basicAuth = '${base64Encode(utf8.encode('$basicUser:$basicPassword'))}';

  static String dateOfJoining = '';
  static String employeeName = '';

  static List<String> statusList = [
    "On Time (09:30 - 18:00)",
    "Late Arrival (After 09:30)",
    "Early Departure (Before 18:00)",
  ];
  static List<Color> statusColors = [
    Colors.green,
    const Color(0xFFF9A825),
    Colors.red,
  ];
}
