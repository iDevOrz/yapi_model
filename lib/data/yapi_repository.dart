import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:yapi_model/common/network/api_provider.dart';
import 'package:yapi_model/common/network/base_response.dart';
import 'package:yapi_model/data/model/group.dart';
import 'package:yapi_model/data/model/interface_info.dart';
import 'package:yapi_model/data/model/project_info.dart';
import 'package:yapi_model/data/yapi_repository_imp.dart';

part 'yapi_repository.g.dart';

abstract class YapiRepository {
  String get baseUrl;

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
YapiRepository yapiRepository(Ref ref) {
  final baseUrl = ref.watch(baseUrlProvider);
  final token = ref.watch(tokenProvider);
  final apiProvider = ref.watch(
    apiProviderProvider(baseUrl: baseUrl, token: token),
  );
  return YapiRepositoryImp(apiProvider: apiProvider);
}

@Riverpod(keepAlive: true)
class BaseUrl extends _$BaseUrl {
  @override
  String build() => String.fromEnvironment("baseUrl");

  set url(String url) => state = url;
}

@Riverpod(keepAlive: true)
class Token extends _$Token {
  @override
  String build() => String.fromEnvironment("token");

  set token(String token) => state = token;
}
