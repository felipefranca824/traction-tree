// ignore_for_file: avoid_redundant_argument_values
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:folder_tree/src/core/services/rest_client/constants/client_constants.dart';

class DioFactory {
  static Dio create() {
    final dio = Dio(
      BaseOptions(
        baseUrl: ClientConstants.baseUrl,
        headers: {
          HttpHeaders.contentTypeHeader: ContentType.json.mimeType,
        },
      ),
    );

    return dio;
  }
}
