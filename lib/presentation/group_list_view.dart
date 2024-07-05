import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yapi_model/common/widgets/async_value_widget.dart';
import 'package:yapi_model/presentation/group_list_controller.dart';
import 'package:yapi_model/presentation/group_list_item_view.dart';

class GroupListView extends ConsumerWidget {
  const GroupListView({super.key, required this.projectId});

  final int projectId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final groupList =
        ref.watch(groupSearchResultListProvider(projectId: projectId));
    return CustomScrollView(
      slivers: [
        AsyncValueSliverWidget(
          value: groupList,
          data: (value) => SliverList.builder(
            itemCount: value.length,
            itemBuilder: (ct, index) => GroupListItemView(
              data: value[index],
            ),
          ),
          onErrorActionTap: () {
            ref.invalidate(groupListProvider(projectId: projectId));
          },
        ),
      ],
    );
  }
}
