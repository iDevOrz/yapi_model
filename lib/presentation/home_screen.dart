import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yapi_model/common/widgets/async_value_widget.dart';
import 'package:yapi_model/data/yapi_repository.dart';
import 'package:yapi_model/presentation/home_controller.dart';
import 'package:yapi_model/presentation/home_project_item_view.dart';
import 'package:yapi_model/presentation/project_add_bottom_sheet.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({
    super.key,
  });

  @override
  ConsumerState createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final _resultController = ValueNotifier<Future?>(null);

  YapiRepository get _repository => ref.read(yapiRepositoryProvider);

  @override
  void dispose() {
    _resultController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Home"),
        actions: [
          Builder(builder: (context) {
            return IconButton(
              onPressed: () => _onAddButtonTap(context),
              icon: const Icon(Icons.add),
            );
          })
        ],
      ),
      body: AsyncValueWidget(
        value: ref.watch(homeControllerProvider),
        data: (value) => ListView.builder(
          itemCount: value.length,
          itemBuilder: (ct, index) => HomeProjectItemView(
            data: value[index],
          ),
        ),
      ),
    );
  }

  void _onAddButtonTap(BuildContext context) {
    showBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(),
        builder: (ct) {
          return const ProjectAddBottomSheet();
        });
  }
}
