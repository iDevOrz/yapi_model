import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yapi_model/common/widgets/async_value_widget.dart';
import 'package:yapi_model/presentation/home/home_controller.dart';
import 'package:yapi_model/presentation/home/home_project_item_view.dart';
import 'package:yapi_model/presentation/project/project_add_dialog.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({
    super.key,
  });

  @override
  ConsumerState createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Home"),
      ),
      body: AsyncValueWidget(
        value: ref.watch(homeControllerProvider),
        data: (value) => ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: value.length,
          itemBuilder: (ct, index) => HomeProjectItemView(
            data: value[index],
            onDeletePressed: () =>
                ref.read(homeControllerProvider.notifier).delete(value[index]),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _onAddButtonTap(context),
        child: const Icon(Icons.add),
      ),
    );
  }

  void _onAddButtonTap(BuildContext context) {
    showDialog(
      context: context,
      builder: (ct) => const ProjectAddDialog(),
    );
  }
}
