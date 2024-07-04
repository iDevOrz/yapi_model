import 'package:dio/dio.dart';
import 'package:yapi_model/data/base_response.dart';

import 'api_provider.dart';
import 'typedefs.dart';

class ApiProviderImp implements ApiProvider {
  final Dio _dioClient;

  ApiProviderImp({required Dio dioClient}) : _dioClient = dioClient;

  @override
  Future<BaseResponse<T>> get<T>(
      {required String path,
      JSON? queryParameters,
      required T Function(Object data) dataConverter}) {
    return _dioClient.get(path, queryParameters: queryParameters).then(
          (response) => BaseResponse.fromJson(
            response.data,
            (data) => dataConverter(response.data["data"] as Object),
          ),
        );
  }
}
