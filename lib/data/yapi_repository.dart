import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:yapi_model/data/api_provider.dart';
import 'package:yapi_model/data/base_response.dart';
import 'package:yapi_model/data/yapi_repository_imp.dart';
import 'package:yapi_model/domain/interface_info.dart';
import 'package:yapi_model/domain/project_info.dart';

import '../domain/group.dart';

part 'yapi_repository.g.dart';

abstract class YapiRepository {
  ///获取项目基本信息
  Future<BaseResponse<ProjectInfo>> getProject();

  /// 获取接口列表数据
  /// [projectId] 项目id
  Future<BaseResponse<List<Group>>> getListMenu({required int projectId});

  /// 获取接口详细信息
  /// [id] 接口id
  Future<BaseResponse<InterfaceInfo>> getInterfaceInfo({required int id});
}

@riverpod
YapiRepository yapiRepository(YapiRepositoryRef ref) {
  final baseUrl = ref.watch(baseUrlProvider);
  final token = ref.watch(tokenProvider);
  final apiProvider = ref.watch(
    apiProviderProvider(baseUrl: baseUrl, token: token),
  );
  return YapiRepositoryImp(apiProvider: apiProvider);
}

final baseUrlProvider = StateProvider<String>((ref) {
  return const String.fromEnvironment("baseUrl");
});

final tokenProvider = StateProvider<String>((ref) {
  return const String.fromEnvironment("token");
});
