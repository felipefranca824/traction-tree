// ignore_for_file: avoid_redundant_argument_values
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class DioFactory {
  static Dio create() {
    final dio = Dio(
      BaseOptions(
        headers: {
          HttpHeaders.contentTypeHeader: ContentType.json.mimeType,
        },
      ),
    );

    if (kDebugMode) {
      dio.interceptors.add(
        PrettyDioLogger(
          request: true,
          requestHeader: true,
          responseBody: true,
          responseHeader: true,
          requestBody: true,
          error: true,
          maxWidth: 90,
          compact: true,
        ),
      );
    }

    return dio;
  }
}
