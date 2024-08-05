import 'dart:convert';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yapi_model/data/yapi_repository.dart';
import 'package:yapi_model/domain/project_config.dart';

part 'home_controller.g.dart';

@riverpod
class HomeController extends _$HomeController {
  static const _projectKey = "_projectKey";

  @override
  FutureOr<List<ProjectConfig>> build() async {
    return _loadFormSharedPreferences();
  }

  Future<void> add({required String baseUrl, required String token}) async {
    ref.watch(baseUrlProvider.notifier).state = baseUrl;
    ref.watch(tokenProvider.notifier).state = token;
    final result = await ref.read(yapiRepositoryProvider).getProject();
    final newConfig = ProjectConfig(
      baseUrl: baseUrl,
      token: token,
      name: result.data.name ?? baseUrl,
      id: result.data.id,
    );
    state = AsyncData([newConfig, ...?state.value]);
    await _save(state.requireValue);
  }

  Future<List<ProjectConfig>> _loadFormSharedPreferences() async {
    final sharedInstance = await SharedPreferences.getInstance();
    final projectJson = sharedInstance.getString(_projectKey);
    if (projectJson == null) {
      return [];
    }
    final projectList = jsonDecode(projectJson) as List;
    final result = projectList
        .map((e) => ProjectConfig.fromJson(e as Map<String, dynamic>))
        .toList();
    return result;
  }

  Future<void> _save(List<ProjectConfig> data) async {
    final jsonList = data.map((e) => e.toJson()).toList();
    final jsonString = jsonEncode(jsonList);
    final sharedInstance = await SharedPreferences.getInstance();
    sharedInstance.setString(_projectKey, jsonString);
  }

  Future<void> delete(ProjectConfig project) async {
    final projectList = List<ProjectConfig>.from(state.requireValue);
    state = AsyncData(projectList..remove(project));
    _save(state.requireValue);
  }
}
