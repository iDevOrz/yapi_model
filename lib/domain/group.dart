import 'package:freezed_annotation/freezed_annotation.dart';

part 'group.freezed.dart';
part 'group.g.dart';

@freezed
class Group with _$Group {
  const factory Group({
    int? index,
    @JsonKey(name: "_id") required int id,

    /// 分组名称
    @Default("") String name,
    int? projectId,

    /// 分组描述
    String? desc,
    int? uid,
    int? addTime,
    int? upTime,
    int? v,
    @Default([]) List<Interface> list,
  }) = _Group;

  factory Group.fromJson(Map<String, Object?> json) => _$GroupFromJson(json);
}

@freezed
class Interface with _$Interface {
  const factory Interface({
    int? editUid,
    String? status,
    int? index,
    @JsonKey(name: "_id") required int id,

    /// 请求类型
    String? method,
    int? catid,

    /// 接口名称
    required String title,

    /// 接口路径
    required String path,
    int? projectId,
    int? uid,
    int? addTime,
    int? upTime,
  }) = _Interface;

  factory Interface.fromJson(Map<String, Object?> json) =>
      _$InterfaceFromJson(json);
}

extension GroupSearch on Iterable<Group> {
  Iterable<Group> filter(String search) {
    if (search.isEmpty) {
      return this;
    } else {
      Group? filteredOrNull(Group element) {
        if (element.name.contains(search)) {
          return element;
        } else {
          final filteredInterface = element.list
              .where((interface) => (interface.title.contains(search) ||
                  interface.path.contains(search)))
              .toList();
          if (filteredInterface.isNotEmpty) {
            return element.copyWith(list: filteredInterface);
          }
        }
        return null;
      }

      return map(filteredOrNull).whereType<Group>();
    }
  }
}
