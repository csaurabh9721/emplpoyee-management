
class AppException implements Exception {
  AppException(this._message);
  final String _message;

  @override
  String toString() {
    return _message;
  }
}
