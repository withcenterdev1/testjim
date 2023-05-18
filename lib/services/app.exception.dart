class AppException implements Exception {
  final String code;
  final String message;

  AppException({required this.code, required this.message});

  @override
  String toString() {
    return 'AppException{code: $code, message: $message}';
  }
}
