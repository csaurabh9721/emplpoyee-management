class TeamAttendanceModel {
  final String employeeId;
  final String employeeName;
  final String designation;
  final String checkIn;
  final String checkOut;
  final String status; // Present, Absent, Half Day
  final String avatar;

  TeamAttendanceModel({
    required this.employeeId,
    required this.employeeName,
    required this.designation,
    required this.checkIn,
    required this.checkOut,
    required this.status,
    required this.avatar,
  });

  factory TeamAttendanceModel.fromJson(Map<String, dynamic> json) {
    return TeamAttendanceModel(
      employeeId: json['employeeId'] ?? '',
      employeeName: json['employeeName'] ?? '',
      designation: json['designation'] ?? '',
      checkIn: json['checkIn'] ?? '--:--',
      checkOut: json['checkOut'] ?? '--:--',
      status: json['status'] ?? 'Absent',
      avatar: json['avatar'] ?? '',
    );
  }
}
