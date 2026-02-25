

class DashboardDataModel {
  final String employeeName;
  final String employeeId;
  final TodayAttendance todayAttendance;
  final List<AnnouncementModel> announcements;
  final List<QuickActionModel> quickActions;

  DashboardDataModel({
    required this.employeeName,
    required this.employeeId,
    required this.todayAttendance,
    required this.announcements,
    required this.quickActions,
  });

  factory DashboardDataModel.fromJson(Map<String, dynamic> json) {
    return DashboardDataModel(
      employeeName: json['employeeName'] ?? '',
      employeeId: json['employeeId'] ?? '',
      todayAttendance: TodayAttendance.fromJson(json['nextShift']),
      announcements: (json['announcements'] as List?)
          ?.map((item) => AnnouncementModel.fromJson(item))
          .toList() ?? [],
      quickActions: (json['quickActions'] as List?)
          ?.map((item) => QuickActionModel.fromJson(item))
          .toList() ?? [],
    );
  }
}
class TodayAttendance {
  final String date;
  final String time;
  final String role;

  TodayAttendance({
    required this.date,
    required this.time,
    required this.role,
  });

  factory TodayAttendance.fromJson(Map<String, dynamic> json) {
    return TodayAttendance(
      date: json['date'] ?? '',
      time: json['time'] ?? '',
      role: json['role'] ?? '',
    );
  }
}

class AnnouncementModel {
  final String id;
  final String title;
  final String description;
  final String date;
  final String type;

  AnnouncementModel({
    required this.id,
    required this.title,
    required this.description,
    required this.date,
    required this.type,
  });

  factory AnnouncementModel.fromJson(Map<String, dynamic> json) {
    return AnnouncementModel(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      date: json['date'] ?? '',
      type: json['type'] ?? '',
    );
  }
}

class QuickActionModel {
  final String id;
  final String title;
  final String icon;
  final String route;

  QuickActionModel({
    required this.id,
    required this.title,
    required this.icon,
    required this.route,
  });

  factory QuickActionModel.fromJson(Map<String, dynamic> json) {
    return QuickActionModel(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      icon: json['icon'] ?? '',
      route: json['route'] ?? '',
    );
  }
}