import 'package:yapi_model/data/api_provider.dart';
import 'package:yapi_model/data/base_response.dart';
import 'package:yapi_model/data/group.dart';
import 'package:yapi_model/data/interface_info.dart';
import 'package:yapi_model/data/project.dart';
import 'package:yapi_model/data/typedefs.dart';
import 'package:yapi_model/data/yapi_repository.dart';

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
  Future<BaseResponse<Project>> getProject() {
    return _apiProvider.get(
      path: "/api/project/get",
      dataConverter: (data) => Project.fromJson(data as JSON),
    );
  }
}
