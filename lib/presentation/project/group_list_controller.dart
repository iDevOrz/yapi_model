import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:yapi_model/data/model/group.dart';
import 'package:yapi_model/data/yapi_repository.dart';

part 'group_list_controller.g.dart';

@riverpod
Future<List<Group>> groupList(Ref ref, {required int projectId}) {
  return ref
      .read(yapiRepositoryProvider)
      .getListMenu(projectId: projectId)
      .then((value) => value.data);
}

@riverpod
class GroupListSearch extends _$GroupListSearch {
  @override
  String build() {
    return "";
  }

  set searchText(String text) => state = text;
}

@riverpod
Future<List<Group>> groupSearchResultList(
  Ref ref, {
  required int projectId,
}) async {
  final allData = await ref.watch(
    groupListProvider(projectId: projectId).future,
  );
  final searchText = ref.watch(groupListSearchProvider);
  if (searchText.isEmpty) {
    return allData;
  }
  return allData.filter(searchText).toList();
}
