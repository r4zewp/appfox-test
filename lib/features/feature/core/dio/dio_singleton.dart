// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:appfox_test/features/feature/core/config/config.dart';
import 'package:dio/dio.dart';
import 'endpoints.dart';

class DioSingleton {
  static final DioSingleton _instance = DioSingleton._internal();
  static var _dio;

  factory DioSingleton() {
    DioSingleton._dio ??= Dio(
      BaseOptions(
        baseUrl: Endpoints.root,
        contentType: 'application/json',
        queryParameters: {
          "apiKey": Config.apiKey,
        },
      ),
    );

    return _instance;
  }

  Dio instance() {
    return _dio;
  }

  DioSingleton._internal();
}
