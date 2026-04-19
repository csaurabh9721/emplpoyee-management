import '../../../core/utils/date_formatter.dart';

class HolidayModel {
  final int id;
  final String title;
  final DateTime date;
  final bool optionalHoliday;

  HolidayModel({
    required this.id,
    required this.title,
    required this.date,
    required this.optionalHoliday,
  });

  factory HolidayModel.fromJson(Map<String, dynamic> json) {
    return HolidayModel(
      id: json['id'] ?? 0,
      title: json['name'] ?? "",
      date: DateTime.tryParse(json['date'] ?? "") ?? DateTime.now(),
      optionalHoliday: json['optionalHoliday'] ?? false,
    );
  }

  String get type => optionalHoliday ? "Restricted" : "Public";

  String get getFormattedDate => date.ddMmYyyy();

  String get getDayName {
    final List<String> weekdays = [
      "",
      "Monday",
      "Tuesday",
      "Wednesday",
      "Thursday",
      "Friday",
      "Saturday",
      "Sunday"
    ];
    return weekdays[date.weekday];
  }
}
