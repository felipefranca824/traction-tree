import '../../../exceptions/app_exceptions.dart';

class ClientException extends AppException {
  final int statusCode;

  ClientException({
    required super.message,
    required super.stackTrace,
    required this.statusCode,
  });
}
