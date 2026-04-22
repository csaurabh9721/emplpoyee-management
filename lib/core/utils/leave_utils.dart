import 'package:flutter/material.dart';

class LeaveUtils {
  static Color getColorFromString(String value) {
    switch (value.toUpperCase()) {
      case 'EL':
        return Colors.indigo;
      case 'CL':
        return Colors.green;
      case 'RH':
        return Colors.orange;
      case 'SL':
        return Colors.cyan;
      default:
        return Colors.grey;
    }
  }

  static IconData getIconFromString(String value) {
    switch (value.toUpperCase()) {
      case 'EL':
        return Icons.event_available;
      case 'SL':
        return Icons.medical_services;
      case 'RH':
        return Icons.person;
      case 'CL':
        return Icons.widgets_rounded;
      default:
        return Icons.dashboard;
    }
  }

  static IconData getIconForStatus(String status) {
    switch (status.toUpperCase()) {
      case 'APPROVED':
        return Icons.check_circle_outline;
      case 'PENDING':
        return Icons.history;
      case 'REJECTED':
        return Icons.cancel_outlined;
        case 'WITHDRAWN':
        return Icons.delete_outline;
      default:
        return Icons.info_outline;
    }
  }

  static Color statusColor(String status) {
    switch (status.toUpperCase()) {
      case 'PENDING':
        return Colors.orange;
      case 'APPROVED':
        return Colors.green;
      case 'REJECTED':
        return Colors.red;
        case 'WITHDRAWN':
        return Colors.grey;
      default:
        return Colors.grey;
    }
  }
}
