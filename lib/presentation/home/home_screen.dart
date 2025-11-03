import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yapi_model/common/widgets/async_value_widget.dart';
import 'package:yapi_model/data/model/project_config.dart';
import 'package:yapi_model/presentation/home/home_controller.dart';
import 'package:yapi_model/presentation/project/project_add_dialog.dart';

import 'home_project_item_view.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Home")),
      body: AsyncValueWidget(
        value: ref.watch(homeControllerProvider),
        data: (value) => _buildData(context, value: value),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _onAddButtonTap(context),
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildData(
    BuildContext context, {
    required List<ProjectConfig> value,
  }) {
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: value.length,
      itemBuilder: (ct, index) => HomeProjectItemView(
        data: value[index],
        onDeletePressed: (project) =>
            _onDeletePressed(context, ref, project: project),
      ),
      separatorBuilder: (BuildContext context, int index) =>
          SizedBox(height: 8),
    );
  }

  void _onDeletePressed(
    BuildContext context,
    WidgetRef ref, {
    required ProjectConfig project,
  }) {
    ref.read(homeControllerProvider.notifier).delete(project);
  }

  void _onAddButtonTap(BuildContext context) {
    showDialog(context: context, builder: (ct) => const ProjectAddDialog());
  }
}
