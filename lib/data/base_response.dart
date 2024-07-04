import 'package:freezed_annotation/freezed_annotation.dart';

part 'base_response.g.dart';
part 'base_response.freezed.dart';



//https://pub.dev/packages/freezed#deserializing-generic-classes
@Freezed(genericArgumentFactories: true)
class BaseResponse<T> with _$BaseResponse<T> {

  const factory BaseResponse({
    required int errcode,
    required String errmsg,
    T? data,
  }) = _BaseResponse;


factory BaseResponse.fromJson(Map<String, dynamic> json, T Function(Object?) fromJsonT) => _$BaseResponseFromJson(json, fromJsonT);
}
