import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'dio_provider.g.dart';

const Duration _timeout = Duration(seconds: 25);

@riverpod
Dio dio(Ref ref, {required String baseUrl, required String token}) {
  final dio = Dio(
    BaseOptions(
      baseUrl: baseUrl,
      sendTimeout: _timeout,
      connectTimeout: _timeout,
      receiveTimeout: _timeout,
      queryParameters: {"token": token},
      headers: {"User-Agent": HttpClient().userAgent},
    ),
  );
  if (kDebugMode) {
    dio.interceptors.add(LogInterceptor(responseBody: true));
  }
  return dio;
}
