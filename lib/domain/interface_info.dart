import 'package:freezed_annotation/freezed_annotation.dart';

part 'interface_info.freezed.dart';
part 'interface_info.g.dart';

@freezed
class InterfaceInfo with _$InterfaceInfo {
  const factory InterfaceInfo({
    @JsonKey(name: 'query_path') QueryPath? queryPath,
    @JsonKey(name: 'edit_uid') int? editUid,
    String? status,
    String? type,
    @JsonKey(name: 'req_body_is_json_schema') bool? reqBodyIsJsonSchema,
    @JsonKey(name: 'res_body_is_json_schema') bool? resBodyIsJsonSchema,
    @JsonKey(name: 'api_opened') bool? apiOpened,
    int? index,
    @JsonKey(name: '_id') required int id,
    String? method,
    int? catid,
    required String title,
    required String path,
    @JsonKey(name: 'project_id') required int projectId,
    @JsonKey(name: 'res_body_type') String? resBodyType,
    int? uid,
    @JsonKey(name: 'add_time') int? addTime,
    @JsonKey(name: 'up_time') int? upTime,
    @JsonKey(name: 'req_query') List<ReqQuery>? reqQuery,
    @JsonKey(name: 'req_headers') List<ReqHeaders>? reqHeaders,
    @JsonKey(name: '__v') int? v,
    String? desc,
    String? markdown,

    /// 描述入参 Body 的Json String,可反序列化为 [Body]
    @JsonKey(name: 'req_body_other') String? reqBodyOther,
    @JsonKey(name: 'req_body_type') String? reqBodyType,

    /// 描述返回值 Body 的Json String,可反序列化为 [Body]
    @JsonKey(name: 'res_body') String? resBody,
    String? username,
  }) = _InterfaceInfo;

  factory InterfaceInfo.fromJson(Map<String, Object?> json) =>
      _$InterfaceInfoFromJson(json);
}

@freezed
class QueryPath with _$QueryPath {
  const factory QueryPath({
    /// 请求路径
    String? path,
  }) = _QueryPath;

  factory QueryPath.fromJson(Map<String, Object?> json) =>
      _$QueryPathFromJson(json);
}

@freezed
class ReqQuery with _$ReqQuery {
  const factory ReqQuery({
    @JsonKey(name: 'required') String? required,
    @JsonKey(name: '_id') required String id,

    /// QueryName
    String? name,

    /// 示例
    String? example,

    /// 备注
    String? desc,
  }) = _ReqQuery;

  factory ReqQuery.fromJson(Map<String, Object?> json) =>
      _$ReqQueryFromJson(json);
}

@freezed
class ReqHeaders with _$ReqHeaders {
  const factory ReqHeaders({
    String? required,
    String? id,

    /// Header Key
    String? name,

    /// Header Value
    String? value,

    /// Header 示例
    String? example,

    /// Header 描述
    String? desc,
  }) = _ReqHeaders;

  factory ReqHeaders.fromJson(Map<String, Object?> json) =>
      _$ReqHeadersFromJson(json);
}

@freezed
class Body with _$Body {
  const factory Body({
    /// 字段类型
    @Default(DataType.string) DataType type,

    /// 当 Type 为 object 时有值,
    /// Key：字段名；Value：字段对应的数据结构
    Map<String, Body>? properties,

    /// 当 Type 为 array 时有值；
    /// 描述数组 element 类型
    Body? items,

    /// 必填字段
    List<String>? required,

    /// 字段名
    @Default("") String title,

    /// 字段备注
    @Default("") description,
  }) = _Body;

  factory Body.fromJson(Map<String, Object?> json) => _$BodyFromJson(json);
}

enum DataType {
  string,
  number,
  array,
  object,
  boolean,
  integer,
}
