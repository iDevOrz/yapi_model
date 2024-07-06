import 'package:flutter/material.dart';

import 'group_list_view.dart';

class ProjectScreen extends StatelessWidget {
  const ProjectScreen({super.key, required this.projectId});

  final int projectId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("接口列表"),
      ),
      body: GroupListView(projectId: projectId),
    );
  }
}
