import '../models/leave_approval_model.dart';

class LeaveApprovalService {
  Future<List<LeaveApprovalModel>> getPendingLeaves() async {
    // Simulate API call
    await Future.delayed(const Duration(seconds: 1));
    return [
      LeaveApprovalModel(
        id: '1',
        employeeName: 'John Doe',
        employeeId: 'EMP001',
        leaveType: 'Annual Leave',
        startDate: DateTime.now().add(const Duration(days: 5)),
        endDate: DateTime.now().add(const Duration(days: 7)),
        reason: 'Family vacation',
        status: 'Pending',
        appliedDate: DateTime.now().subtract(const Duration(days: 2)),
      ),
      LeaveApprovalModel(
        id: '2',
        employeeName: 'Jane Smith',
        employeeId: 'EMP002',
        leaveType: 'Sick Leave',
        startDate: DateTime.now().add(const Duration(days: 1)),
        endDate: DateTime.now().add(const Duration(days: 1)),
        reason: 'Not feeling well',
        status: 'Pending',
        appliedDate: DateTime.now().subtract(const Duration(days: 1)),
      ),
    ];
  }

  Future<bool> approveLeave(LeaveApprovalRequest request) async {
    // Simulate API call
    await Future.delayed(const Duration(seconds: 1));
    return true;
  }

  Future<bool> rejectLeave(LeaveApprovalRequest request) async {
    // Simulate API call
    await Future.delayed(const Duration(seconds: 1));
    return true;
  }
}
