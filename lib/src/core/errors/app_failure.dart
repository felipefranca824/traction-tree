class AppFailure implements Exception {
  final String messageError;

  AppFailure({required this.messageError});
}
