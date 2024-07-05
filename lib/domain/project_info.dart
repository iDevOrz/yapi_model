import 'package:freezed_annotation/freezed_annotation.dart';

part 'project_info.freezed.dart';
part 'project_info.g.dart';

@freezed
class ProjectInfo with _$ProjectInfo {
  const factory ProjectInfo(
      {bool? switchNotice,
      bool? isMockOpen,
      bool? strice,
      bool? isJson5,
      @JsonKey(name: "_id") required int id,
      String? name,
      String? basepath,
      String? projectType,
      int? uid,
      int? groupId,
      String? icon,
      String? color,
      int? addTime,
      int? upTime,
      List<ProjectTag>? tag,
      bool? role}) = _ProjectInfo;

  factory ProjectInfo.fromJson(Map<String, dynamic> json) =>
      _$ProjectInfoFromJson(json);
}

@freezed
class ProjectTag with _$ProjectTag {
  const factory ProjectTag({
    String? id,
    String? name,
    String? desc,
  }) = _ProjectTag;

  factory ProjectTag.fromJson(Map<String, dynamic> json) =>
      _$ProjectTagFromJson(json);
}
