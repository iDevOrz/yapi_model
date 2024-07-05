import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:yapi_model/data/yapi_repository.dart';
import 'package:yapi_model/domain/group.dart';

part 'group_list_controller.g.dart';

@riverpod
Future<List<Group>> groupList(GroupListRef ref, {required int projectId}) {
  return ref
      .read(yapiRepositoryProvider)
      .getListMenu(projectId: projectId)
      .then((value) => value.data ?? []);
}

final groupListSearchProvider = StateProvider.autoDispose<String>((ref) {
  return "";
});

@riverpod
Future<List<Group>> groupSearchResultList(GroupSearchResultListRef ref,
    {required int projectId}) async {
  final allData =
      await ref.watch(groupListProvider(projectId: projectId).future);
  final searchText = ref.watch(groupListSearchProvider);
  if (searchText.isEmpty) {
    return allData;
  }
  return allData.filter(searchText).toList();
}
