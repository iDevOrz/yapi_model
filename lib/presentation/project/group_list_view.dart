import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yapi_model/common/widgets/async_value_widget.dart';

import 'group_list_controller.dart';
import 'group_list_item_view.dart';

class GroupListView extends ConsumerWidget {
  const GroupListView({super.key, required this.projectId});

  final int projectId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final groupList =
        ref.watch(groupSearchResultListProvider(projectId: projectId));
    return CustomScrollView(
      slivers: [
        SliverPadding(
          padding: const EdgeInsets.all(12),
          sliver: SliverToBoxAdapter(
            child: SearchBar(
              padding: const WidgetStatePropertyAll(EdgeInsets.all(8)),
              constraints: const BoxConstraints(minHeight: 40),
              onChanged: (value) {
                ref.watch(groupListSearchProvider.notifier).state = value;
              },
            ),
          ),
        ),
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
