import 'package:yapi_model/domain/group.dart';
import 'package:yapi_model/domain/interface_info.dart';
import 'package:yapi_model/domain/project_info.dart';

import 'api_provider.dart';
import 'base_response.dart';
import 'typedefs.dart';
import 'yapi_repository.dart';

class YapiRepositoryImp implements YapiRepository {
  final ApiProvider _apiProvider;

  YapiRepositoryImp({required ApiProvider apiProvider})
      : _apiProvider = apiProvider;

  @override
  Future<BaseResponse<InterfaceInfo>> getInterfaceInfo({required int id}) {
    return _apiProvider.get(
      path: "/api/interface/get",
      queryParameters: {"id": id},
      dataConverter: (data) => InterfaceInfo.fromJson(data as JSON),
    );
  }

  @override
  Future<BaseResponse<List<Group>>> getListMenu({required int projectId}) {
    return _apiProvider.get(
      path: "/api/interface/list_menu",
      queryParameters: {"project_id": projectId},
      dataConverter: (data) {
        final dataJson = data as List;
        return dataJson.map((item) => Group.fromJson(item as JSON)).toList();
      },
    );
  }

  @override
  Future<BaseResponse<ProjectInfo>> getProject() {
    return _apiProvider.get(
      path: "/api/project/get",
      dataConverter: (data) => ProjectInfo.fromJson(data as JSON),
    );
  }
}
