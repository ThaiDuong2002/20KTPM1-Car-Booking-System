class BaseException implements Exception {
  final String message;
  int? code = 0;

  BaseException({required this.message, this.code});
}
