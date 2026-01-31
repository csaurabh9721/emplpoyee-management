extension DateExtension on DateTime {
  String ddMmYyyy() {
    final day = this.day.toString().padLeft(2, '0');
    final month = this.month.toString().padLeft(2, '0');
    final year = this.year.toString();
    return '$day/$month/$year';
  }
  String mmDDYyyy() {
    final day = this.day.toString().padLeft(2, '0');
    final month = this.month.toString().padLeft(2, '0');
    final year = this.year.toString();
    return '$month/$day/$year';
  }
  String ddMonthYYYY(){
    final day = this.day.toString().padLeft(2, '0');
    final month = _monthMap[this.month]!;
    final year = this.year.toString();
    return '$day-$month-$year';
  }
  String monthYYYY(){
    final month = _monthMap[this.month]!;
    final year = this.year.toString();
    return '$month-$year';
  }
  String ddMm() {
    final day = this.day.toString().padLeft(2, '0');
    final month = this.month.toString().padLeft(2, '0');
    return '$day/$month';
  }
}
Map<int, String> _monthMap = {
  1: "Jan",
  2: "Feb",
  3: "Mar",
  4: "Apr",
  5: "May",
  6: "Jun",
  7: "Jul",
  8: "Aug",
  9: "Sep",
  10: "Oct",
  11: "Nov",
  12: "Dec",
};

bool strDateIsAfter(String d1, String d2) {
  try {
    final List<String> parts1 = d1.split("/");
    final List<String> parts2 = d2.split("/");
    final DateTime dateTime1 = DateTime.parse("${parts1[2]}-${parts1[1]}-${parts1[0]}");
    final DateTime dateTime2 = DateTime.parse("${parts2[2]}-${parts2[1]}-${parts2[0]}");
    return dateTime1.isAfter(dateTime2);
  } catch (e) {
    return false;
  }
}