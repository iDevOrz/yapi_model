import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:yapi_model/data/yapi_repository.dart';
import 'package:yapi_model/domain/interface_info.dart';

part 'mock_path.g.dart';

class MockPath {
  final String baseUrl;

  /// 路径
  final String path;

  /// 请求方式
  final String method;

  String get fullPath => baseUrl + path;

  MockPath({required this.baseUrl, required this.method, required this.path});
}

@riverpod
MockPath mockPath(MockPathRef ref, {required InterfaceInfo interface}) {
  final baseUrl = ref.watch(yapiRepositoryProvider).baseUrl;
  return MockPath(
    baseUrl: "$baseUrl/mock/${interface.projectId}",
    path: interface.path,
    method: interface.method!,
  );
}
