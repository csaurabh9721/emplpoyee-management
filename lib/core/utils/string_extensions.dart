extension AppStringExtensions on String {
  String get yyyyMm {
    try {
      final List<String> split = this.split("/");
      return "${split[2]}/${split[1]}";
    } catch (e) {
      return "$e";
    }
  }

  String get firstLettersOfWords {
    if (trim().isEmpty) {
      return "";
    }
    final List<String> words = trim().split(RegExp(r'\s+'));
    if (words.isEmpty) return "";
    return words.map((word) => word.isNotEmpty ? word[0].toUpperCase() : "").join();
  }

  bool isEqual(String str) {
    if (trim().toLowerCase() == str.trim().toLowerCase()) {
      return true;
    }
    return false;
  }

  String get firstLetters {
    if (trim().isEmpty) {
      return "";
    }
    final List<String> words = trim().split(RegExp(r'\s+'));
    if (words.isEmpty) return "";
    return words.map((word) => word.isNotEmpty ? word[0].toUpperCase() : "").join();
  }
}
