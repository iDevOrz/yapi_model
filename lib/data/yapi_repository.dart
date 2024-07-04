import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:yapi_model/data/api_provider.dart';
import 'package:yapi_model/data/base_response.dart';
import 'package:yapi_model/data/interface_info.dart';
import 'package:yapi_model/data/project.dart';
import 'package:yapi_model/data/yapi_repository_imp.dart';

import 'group.dart';
part 'yapi_repository.g.dart';

abstract class YapiRepository {
  ///获取项目基本信息
  Future<BaseResponse<Project>> getProject();

  /// 获取接口列表数据
  /// [projectId] 项目id
  Future<BaseResponse<List<Group>>> getListMenu({required int projectId});

  /// 获取接口详细信息
  /// [id] 接口id
  Future<BaseResponse<InterfaceInfo>> getInterfaceInfo({required int id});
}

@riverpod
YapiRepository yapiRepository(YapiRepositoryRef ref) {
  return YapiRepositoryImp(apiProvider: ref.watch(apiProviderProvider));
}
