import 'package:flutter/material.dart';

class AttendanceEntity {

  const AttendanceEntity({
    required this.biometricDetails,
    required this.attendanceSummary,
  });
  final List<BiometricDetailsEntity> biometricDetails;
  final List<AttendanceSummary> attendanceSummary;

  String get totalWorkingHour {
    Duration totalDuration = Duration.zero;
    for (var e in biometricDetails) {
      final String shortHoursStr = e.workingHours;
      final List<String> parts = shortHoursStr.split(':');
      final int hours = int.tryParse(parts[0]) ?? 0;
      final int minutes = int.tryParse(parts[1]) ?? 0;
      totalDuration += Duration(hours: hours, minutes: minutes);
    }
    final formatted =
        '${totalDuration.inHours.toString().padLeft(2, '0')}:${(totalDuration.inMinutes % 60).toString().padLeft(2, '0')}';
    return formatted;
  }

  String get totalShortHour {
    Duration totalDuration = Duration.zero;
    for (var e in biometricDetails) {
      final String shortHoursStr = e.shortHour;
      final isNegative = shortHoursStr.startsWith('-');
      final cleanStr = isNegative ? shortHoursStr.substring(1) : shortHoursStr;
      final parts = cleanStr.split(':');
      final hours = int.tryParse(parts[0]) ?? 0;
      final minutes = int.tryParse(parts[1]) ?? 0;
      final duration = Duration(hours: hours, minutes: minutes);
      totalDuration += isNegative ? -duration : duration;
    }
    final sign = totalDuration.isNegative ? '-' : '';
    final absDuration = totalDuration.abs();
    final formatted =
        '$sign${absDuration.inHours.toString().padLeft(2, '0')}:${(absDuration.inMinutes % 60).toString().padLeft(2, '0')}';
    return formatted;
  }
  Color get totalShortHourColor {
    return totalShortHour.startsWith('-')
        ? const Color(0xFFB71C1C)
        : const Color(0xFF1B5E20);
  }

  String get totalPenalties {
    final int penalty = 0;
    for (var e in biometricDetails) {
      penalty + e.penaltyDays;
    }
    return penalty.toString();
  }
}

class AttendanceSummary {

  const AttendanceSummary({
    required this.icon,
    required this.title,
    required this.value,
    required this.index,
  });
  final IconData icon;
  final String title;
  final String value;
  final int index;

  Color get cardColor {
    switch (index) {
      case 1:
        return Colors.blue.shade800;
      case 2:
        return Colors.grey.shade800;
      case 3:
        return Colors.red.shade800;
      case 4:
        return Colors.yellow.shade800;
      case 5:
        return Colors.pinkAccent.shade700;
      case 6:
        return Colors.purple.shade800;
      case 7:
        return Colors.orange.shade800;
      default:
        return Colors.green.shade800;
    }
  }
}

class BiometricDetailsEntity {

  const BiometricDetailsEntity({
    required this.date,
    required this.inTime,
    required this.outTime,
    required this.shortHour,
    required this.status,
    required this.weekDay,
    required this.description,
    required this.penaltyDays,
    required this.workingHours,
  });
  final String date;
  final String inTime;
  final String outTime;
  final String shortHour;
  final String status;
  final String weekDay;
  final String description;
  final int penaltyDays;
  final String workingHours;

  ///Get Status color
  Color get statusColor {
    return status == "Half Day"
        ? const Color(0xFFFBC02D)
        : status == "Present"
            ? const Color(0xFF1B5E20)
            : const Color(0xFFB71C1C);
  }

  ///Get ShortHour color
  Color get shortHourColor {
    return shortHour.startsWith("-")
        ? const Color(0xFFB71C1C)
        : const Color(0xFF1B5E20);
  }
}