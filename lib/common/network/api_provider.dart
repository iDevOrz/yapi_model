import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:yapi_model/common/network/dio_provider.dart';
import 'package:yapi_model/common/network/typedefs.dart';

import 'api_provider_imp.dart';
import 'base_response.dart';

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

@riverpod
ApiProvider apiProvider(
  Ref ref, {
  required String baseUrl,
  required String token,
}) {
  return ApiProviderImp(
    dioClient: ref.watch(dioProvider(baseUrl: baseUrl, token: token)),
  );
}
