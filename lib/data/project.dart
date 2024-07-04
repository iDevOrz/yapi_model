import 'package:freezed_annotation/freezed_annotation.dart';

part 'project.g.dart';

part 'project.freezed.dart';

@freezed
class Project with _$Project {
  const factory Project({
  bool? switchNotice,
  bool? isMockOpen,
  bool? strice,
  bool? isJson5,
  int? id,
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
  bool? role}) = _Project;
  factory Project.fromJson(Map<String, dynamic> json) => _$ProjectFromJson(json);
}

@freezed
class ProjectTag with _$ProjectTag {
  const factory ProjectTag({String? id,
    String? name,
    String? desc,}) = _ProjectTag;


  factory ProjectTag.fromJson(Map<String, dynamic> json) =>
      _$ProjectTagFromJson(json);
}
