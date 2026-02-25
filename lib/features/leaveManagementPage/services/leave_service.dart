import 'package:flutter/material.dart';

import '../models/leave_models.dart';

class LeaveService {
  Future<LeaveManagementDataModel> getLeaveManagementData() async {
    try {
      // Simulate API delay
      await Future.delayed(const Duration(seconds: 2));
      
      // Return dummy data
      return LeaveManagementDataModel(
        leaveBalances: [
          LeaveBalanceModel(
            type: 'Annual',
            totalDays: 15,
            usedDays: 3,
            availableDays: 12,
            icon: 'calendar_today',
            color: Colors.indigo,
          ),
          LeaveBalanceModel(
            type: 'Sick',
            totalDays: 7,
            usedDays: 2,
            availableDays: 5,
            icon: 'medical_services',
            color: Colors.green,
          ),
          LeaveBalanceModel(
            type: 'Personal',
            totalDays: 5,
            usedDays: 2,
            availableDays: 3,
            icon: 'person',
            color: Colors.orange,
          ),
        ],
        recentRequests: [
          LeaveRequestModel(
            id: '1',
            type: 'Annual Leave',
            startDate: 'Oct 12, 2023',
            endDate: 'Oct 15, 2023',
            days: 4,
            status: 'PENDING',
            reason: 'Family vacation',
            appliedDate: DateTime.parse('2023-10-10'),
          ),
          LeaveRequestModel(
            id: '2',
            type: 'Sick Leave',
            startDate: 'Sep 20, 2023',
            endDate: 'Sep 20, 2023',
            days: 1,
            status: 'APPROVED',
            reason: 'Medical appointment',
            appliedDate: DateTime.parse('2023-09-19'),
          ),
          LeaveRequestModel(
            id: '3',
            type: 'Personal Leave',
            startDate: 'Aug 05, 2023',
            endDate: 'Aug 06, 2023',
            days: 2,
            status: 'REJECTED',
            reason: 'Personal work',
            appliedDate: DateTime.parse('2023-08-04'),
          ),
          LeaveRequestModel(
            id: '4',
            type: 'Annual Leave',
            startDate: 'Jul 10, 2023',
            endDate: 'Jul 14, 2023',
            days: 5,
            status: 'APPROVED',
            reason: 'Summer vacation',
            appliedDate: DateTime.parse('2023-07-08'),
          ),
        ],
      );
    } catch (e) {
      throw Exception('Failed to load leave management data: $e');
    }
  }

  Future<List<LeaveRequestModel>> getAllLeaveRequests() async {
    try {
      await Future.delayed(const Duration(seconds: 1));
      
      // Return more detailed leave requests
      return [
        LeaveRequestModel(
          id: '1',
          type: 'Annual Leave',
          startDate: 'Oct 12, 2023',
          endDate: 'Oct 15, 2023',
          days: 4,
          status: 'PENDING',
          reason: 'Family vacation',
          appliedDate: DateTime.parse('2023-10-10'),
        ),
        LeaveRequestModel(
          id: '2',
          type: 'Sick Leave',
          startDate: 'Sep 20, 2023',
          endDate: 'Sep 20, 2023',
          days: 1,
          status: 'APPROVED',
          reason: 'Medical appointment',
          appliedDate: DateTime.parse('2023-09-19'),
        ),
        LeaveRequestModel(
          id: '3',
          type: 'Personal Leave',
          startDate: 'Aug 05, 2023',
          endDate: 'Aug 06, 2023',
          days: 2,
          status: 'REJECTED',
          reason: 'Personal work',
          appliedDate: DateTime.parse('2023-08-04'),
        ),
        LeaveRequestModel(
          id: '4',
          type: 'Annual Leave',
          startDate: 'Jul 10, 2023',
          endDate: 'Jul 14, 2023',
          days: 5,
          status: 'APPROVED',
          reason: 'Summer vacation',
          appliedDate: DateTime.parse('2023-07-08'),
        ),
        LeaveRequestModel(
          id: '5',
          type: 'Sick Leave',
          startDate: 'Jun 15, 2023',
          endDate: 'Jun 16, 2023',
          days: 2,
          status: 'APPROVED',
          reason: 'Flu symptoms',
          appliedDate: DateTime.parse('2023-06-14'),
        ),
      ];
    } catch (e) {
      throw Exception('Failed to load leave requests: $e');
    }
  }
}
