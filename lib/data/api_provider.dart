import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:yapi_model/data/api_provider_imp.dart';
import 'package:yapi_model/data/base_response.dart';
import 'package:yapi_model/data/dio_provider.dart';
import 'package:yapi_model/data/typedefs.dart';

part 'api_provider.g.dart';

abstract class ApiProvider {
  Future<BaseResponse<T>> get<T>({
    required String path,
    JSON? queryParameters,
    required T Function(Object data) dataConverter,
  });
}

const _baseUrl = String.fromEnvironment("baseUrl");

const _token = String.fromEnvironment("token");

@riverpod
ApiProvider apiProvider(ApiProviderRef ref) {
  return ApiProviderImp(
    dioClient: ref.watch(
      dioProvider(
        baseUrl: _baseUrl,
        token: _token,
      ),
    ),
  );
}
