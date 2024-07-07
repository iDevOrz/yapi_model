import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:yapi_model/data/api_provider_imp.dart';
import 'package:yapi_model/data/base_response.dart';
import 'package:yapi_model/data/dio_provider.dart';
import 'package:yapi_model/data/typedefs.dart';

part 'api_provider.g.dart';

abstract class ApiProvider {
  String get baseUrl;

  Future<BaseResponse<T>> get<T>({
    required String path,
    JSON? queryParameters,
    Options options,
    required T Function(Object data) dataConverter,
  });
}

const _baseUrl = String.fromEnvironment("baseUrl");

const _token = String.fromEnvironment("token");

@riverpod
ApiProvider apiProvider(
  ApiProviderRef ref, {
  required String baseUrl,
  required String token,
}) {
  return ApiProviderImp(
    dioClient: ref.watch(
      dioProvider(
        baseUrl: baseUrl,
        token: token,
      ),
    ),
  );
}
