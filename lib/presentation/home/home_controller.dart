import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:yapi_model/data/yapi_repository.dart';
import 'package:yapi_model/domain/project_config.dart';

part 'home_controller.g.dart';

@riverpod
class HomeController extends _$HomeController {
  @override
  FutureOr<List<ProjectConfig>> build() async {
    return [];
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
  }
}
