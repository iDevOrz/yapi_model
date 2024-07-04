import 'package:freezed_annotation/freezed_annotation.dart';
part 'interface_info.freezed.dart';
part 'interface_info.g.dart';


@freezed
class InterfaceInfo with _$InterfaceInfo {
  const factory InterfaceInfo({
    QueryPath? queryPath,
    int? editUid,
    String? status,
    String? type,
    bool? reqBodyIsJsonSchema,
    bool? resBodyIsJsonSchema,
    bool? apiOpened,
    int? index,
    int? id,
    String? method,
    int? catid,
    String? title,
    /// 接口路径
    String? path,
    int? projectId,
    String? resBodyType,
    int? uid,
    int? addTime,
    int? upTime,
    List<ReqQuery>? reqQuery,
    List<ReqHeaders>? reqHeaders,
    int? v,
    String? desc,
    String? markdown,
    /// 描述入参 Body 的Json String,可反序列化为 [ReqBodyOther]
    String? reqBodyOther,
    String? reqBodyType,
    /// 描述返回值 Body 的Json String,可反序列化为 [ReqBodyOther]
    String? resBody,
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
    String? requiredProperty,
    String? id,
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
    String? requiredProperty,
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
    Map<String,Body>? properties,
    /// 必填字段
    List<String>? requiredProperty,
  }) = _Body;

  factory Body.fromJson(Map<String, Object?> json) =>
      _$BodyFromJson(json);
}

enum DataType {
  string,
  number,
  array,
  object,
  boolean,
  integer,
}

