import '../models/leave_apply_models.dart';

class LeaveApplyService {
  Future<LeaveBalanceResponse> getLeaveBalances() async {
    // Simulate API delay
    await Future.delayed(const Duration(seconds: 1));

    // Dummy data
    final List<LeaveBalanceModel> leaveBalances = [
      LeaveBalanceModel(
        leaveType: 'Annual Leave',
        availableDays: 12.0,
        totalDays: 21.0,
        description: 'Annual paid leave entitlement',
      ),
      LeaveBalanceModel(
        leaveType: 'Sick Leave',
        availableDays: 5.0,
        totalDays: 10.0,
        description: 'Medical leave entitlement',
      ),
      LeaveBalanceModel(
        leaveType: 'Casual Leave',
        availableDays: 3.5,
        totalDays: 7.0,
        description: 'Casual leave entitlement',
      ),
      LeaveBalanceModel(
        leaveType: 'Unpaid Leave',
        availableDays: 0.0,
        totalDays: 30.0,
        description: 'Unpaid leave (no balance)',
      ),
    ];

    return LeaveBalanceResponse(
      success: true,
      message: 'Leave balances retrieved successfully',
      leaveBalances: leaveBalances,
    );
  }

  Future<LeaveApplyResponse> applyLeave({
    required String leaveType,
    required DateTime startDate,
    required DateTime endDate,
    required String reason,
  }) async {
    // Simulate API delay
    await Future.delayed(const Duration(seconds: 2));

    // Validate dates
    if (startDate.isAfter(endDate)) {
      return LeaveApplyResponse(
        success: false,
        message: 'Start date cannot be after end date',
      );
    }

    // Check if dates are in the past
    final now = DateTime.now();
    if (startDate.isBefore(DateTime(now.year, now.month, now.day))) {
      return LeaveApplyResponse(
        success: false,
        message: 'Cannot apply for leave in the past',
      );
    }

    // Calculate total days
    final totalDays = (endDate.difference(startDate).inHours / 24) + 1;

    // Get leave balances to validate
    final balanceResponse = await getLeaveBalances();
    final leaveBalance = balanceResponse.leaveBalances
        .firstWhere((balance) => balance.leaveType == leaveType);

    // Check if enough days are available (except for unpaid leave)
    if (leaveType != 'Unpaid Leave' && totalDays > leaveBalance.availableDays) {
      return LeaveApplyResponse(
        success: false,
        message: 'Insufficient leave balance. Available: ${leaveBalance.availableDays.toStringAsFixed(1)} days',
      );
    }

    // Create the leave request
    final leaveRequest = LeaveRequestModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      leaveType: leaveType,
      startDate: startDate,
      endDate: endDate,
      reason: reason,
      status: 'PENDING',
      appliedDate: DateTime.now(),
      totalDays: totalDays,
    );

    return LeaveApplyResponse(
      success: true,
      message: 'Leave request submitted successfully',
      leaveRequest: leaveRequest,
    );
  }

  Future<List<LeaveRequestModel>> getLeaveHistory() async {
    // Simulate API delay
    await Future.delayed(const Duration(seconds: 1));

    // Dummy historical data
    return [
      LeaveRequestModel(
        id: '1',
        leaveType: 'Annual Leave',
        startDate: DateTime(2023, 10, 12),
        endDate: DateTime(2023, 10, 15),
        reason: 'Family vacation',
        status: 'PENDING',
        appliedDate: DateTime(2023, 10, 1),
        totalDays: 4.0,
      ),
      LeaveRequestModel(
        id: '2',
        leaveType: 'Sick Leave',
        startDate: DateTime(2023, 9, 20),
        endDate: DateTime(2023, 9, 20),
        reason: 'Medical appointment',
        status: 'APPROVED',
        appliedDate: DateTime(2023, 9, 19),
        totalDays: 1.0,
        approverComments: 'Approved with medical certificate',
      ),
      LeaveRequestModel(
        id: '3',
        leaveType: 'Personal Leave',
        startDate: DateTime(2023, 8, 5),
        endDate: DateTime(2023, 8, 6),
        reason: 'Personal work',
        status: 'REJECTED',
        appliedDate: DateTime(2023, 8, 1),
        totalDays: 2.0,
        approverComments: 'Insufficient notice period',
      ),
      LeaveRequestModel(
        id: '4',
        leaveType: 'Annual Leave',
        startDate: DateTime(2023, 7, 10),
        endDate: DateTime(2023, 7, 14),
        reason: 'Summer vacation',
        status: 'APPROVED',
        appliedDate: DateTime(2023, 6, 15),
        totalDays: 5.0,
      ),
    ];
  }

  double calculateLeaveDays(DateTime startDate, DateTime endDate) {
    if (startDate.isAfter(endDate)) return 0.0;
    
    // Simple calculation - count all days including weekends
    // In a real app, you might want to exclude weekends and holidays
    final duration = endDate.difference(startDate);
    return (duration.inHours / 24) + 1;
  }

  bool isValidLeaveDate(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final selectedDate = DateTime(date.year, date.month, date.day);
    
    // Don't allow dates in the past
    return !selectedDate.isBefore(today);
  }

  String formatDate(DateTime date) {
    const List<String> months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    return '${date.day} ${months[date.month - 1]} ${date.year}';
  }
}
