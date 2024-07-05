import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yapi_model/presentation/group_list_view.dart';

import 'group_list_controller.dart';

class ProjectScreen extends StatelessWidget {
  const ProjectScreen({super.key, required this.projectId});

  final int projectId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Consumer(
          builder: (context, ref, child) {
            return SearchBar(
              constraints: const BoxConstraints(minHeight: 40),
              onChanged: (value) {
                ref.watch(groupListSearchProvider.notifier).state = value;
              },
            );
          },
        ),
      ),
      body: GroupListView(projectId: projectId),
    );
  }
}
