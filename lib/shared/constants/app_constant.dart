import 'dart:convert';

import 'package:flutter/material.dart';

class AppConstant {
  static const String basicUser = 'appdevix';
  static const String basicPassword = '123appdevix456';
  static String basicAuth = base64Encode(utf8.encode('$basicUser:$basicPassword'));

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
  static const List<String> monthList = [
    "January",
    "February",
    "March",
    "April",
    "May",
    "June",
    "July",
    "August",
    "September",
    "October",
    "November",
    "December"
  ];

  static const Map<String, int> getMonthIntMap = {
    "January": 1,
    "February": 2,
    "March": 3,
    "April": 4,
    "May": 5,
    "June": 6,
    "July": 7,
    "August": 8,
    "September": 9,
    "October": 10,
    "November": 11,
    "December": 12
  };
}
