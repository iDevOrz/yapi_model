import 'package:freezed_annotation/freezed_annotation.dart';

part 'project_config.freezed.dart';

@freezed
class ProjectConfig with _$ProjectConfig {
  const factory ProjectConfig(
      {required String baseUrl,
      required String token,
      required String name,
      required int id}) = _ProjectConfig;
}
