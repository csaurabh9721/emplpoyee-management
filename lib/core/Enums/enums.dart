enum ApiStatus { initial, loading, completed, error }

enum SnackBarEnum { success, error, info, warning }

enum ProfileTab { personal, address }

enum LeaveStartPeriod { firstHalf, secondHalf }

enum FilePickSource { camera, gallery, pdf }

enum APIStatus { initial, loading, success, error }

extension PeriodExtension on LeaveStartPeriod {
  String get name {
    switch (this) {
      case LeaveStartPeriod.firstHalf:
        return "First Half";
      case LeaveStartPeriod.secondHalf:
        return "Second Half";
    }
  }
}
