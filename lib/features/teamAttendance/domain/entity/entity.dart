import 'package:flutter/material.dart';

import '../../../../shared/app_color.dart';

final class TeamAttendanceEntity {

  TeamAttendanceEntity({required this.date, required this.weekDay, required this.biometrics});
  final String date;
  final String weekDay;
  final List<DateWiseBiometric> biometrics;

  Color getCardColor(String date) {
    return date == this.date ? AppColors.primary : Colors.white;
  }

  Color getTextColor(String date) {
    return date == this.date ? AppColors.white : Colors.black;
  }

  String get getWeekDay {
    try {
      return weekDay.substring(0, 3);
    } catch (e) {
      return "";
    }
  }

  String get getDay {
    try {
      return date.substring(0, 5);
    } catch (e) {
      return "";
    }
  }
}

final class DateWiseBiometric {
  //final String userId;

  DateWiseBiometric(
      {required this.name,
      required this.eCode,
      required this.inTime,
      required this.outTime,
      required this.weekDay,
      required this.role,
      required this.empId,
     // required this.userId,
      });
  final String name;
  final String eCode;
  final String inTime;
  final String outTime;
  final String weekDay;
  final String role;
  final String empId;

  Color get getInTimeColor {
    try {
      final timeParts = inTime.split(':');
      final hour = int.parse(timeParts[0]);
      final minute = int.parse(timeParts[1]);
      if (hour < 9 || (hour == 9 && minute <= 30)) {
        return Colors.green;
      } else if (hour == 9 && minute > 30 && minute <= 45) {
        return Colors.black;
      } else if (hour == 9 && minute > 45) {
        return Colors.yellow.shade800;
      } else if (hour >= 10) {
        return Colors.red;
      }
      return Colors.black;
    } catch (e) {
      return Colors.black;
    }
  }

  Color get getOutTimeColor {
    try {
      final List<String> timeParts = outTime.split(':');
      final int hour = int.parse(timeParts[0]);
      final int minute = int.parse(timeParts[1]);
      if (hour < 18) {
        return Colors.red;
      }
      if (hour == 18 && minute >= 0 && minute <= 15) {
        return Colors.black;
      }
      if (hour > 18 || (hour == 18 && minute > 15)) {
        return Colors.green;
      }
      return Colors.black;
    } catch (e) {
      return Colors.black;
    }
  }
}
