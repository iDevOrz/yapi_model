import 'package:freezed_annotation/freezed_annotation.dart';

part 'group.freezed.dart';
part 'group.g.dart';


@freezed
class Group with _$Group {
  const factory Group({
    int? index,
    int? id,
    /// 分组名称
    String? name,
    int? projectId,
    /// 分组描述
    String? desc,
    int? uid,
    int? addTime,
    int? upTime,
    int? v,
    List<Interface>? list,
  }) = _Group;

  factory Group.fromJson(Map<String, Object?> json) =>
      _$GroupFromJson(json);
}

@freezed
class Interface with _$Interface {
  const factory Interface({
    int? editUid,
    String? status,
    int? index,
    int? id,
    /// 请求类型
    String? method,
    int? catid,
    /// 接口名称
    String? title,
    /// 接口路径
    String? path,
    int? projectId,
    int? uid,
    int? addTime,
    int? upTime,
  }) = _Interface;

  factory Interface.fromJson(Map<String, Object?> json) => _$InterfaceFromJson(json);
}

