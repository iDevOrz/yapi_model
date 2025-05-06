import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart' show Ref;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'dio_provider.g.dart';

const Duration _timeout = Duration(seconds: 25);

@riverpod
Dio dio(Ref ref, {required String baseUrl, required String token}) {
  return Dio(
    BaseOptions(
      baseUrl: baseUrl,
      sendTimeout: _timeout,
      connectTimeout: _timeout,
      receiveTimeout: _timeout,
      queryParameters: {"token": token},
    ),
  );
}
