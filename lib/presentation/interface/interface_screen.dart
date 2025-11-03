import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yapi_model/common/widgets/async_value_widget.dart';
import 'package:yapi_model/domain/code_util.dart';
import 'package:yapi_model/presentation/interface/interface_controller.dart';
import 'package:yapi_model/presentation/interface/interface_info_view.dart';
import 'package:yapi_model/presentation/interface/interface_split_view.dart';
import 'package:yapi_model/presentation/interface/model_view.dart';

import 'mock_json_view.dart';

class InterfaceScreen extends StatelessWidget {
  const InterfaceScreen({super.key, required this.id});

  final int id;

  InterfaceControllerProvider get provider =>
      interfaceControllerProvider(id: id);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("接口信息"),
        actions: [_buildRefreshIconButton(context)],
      ),
      body: Consumer(
        builder: (context, ref, child) {
          final asyncInfo = ref.watch(provider);
          return AsyncValueWidget(
            value: asyncInfo,
            data: (info) => InterfaceSplitView(
              breakWidth: 1000,
              infoContent: InterfaceInfoView(info: info),
              mockJsonContent: MockJsonView(interface: info),
              modelContent: ModelView(
                models: CodeUtil.gen(info.resBody ?? "{}"),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildRefreshIconButton(BuildContext context) {
    return Consumer(
      builder: (context, ref, loadingWidget) {
        final asyncInfo = ref.watch(provider);
        if (asyncInfo.isLoading) {
          return loadingWidget!;
        }
        return IconButton(
          onPressed: () => _onRefreshTap(context, ref),
          icon: Icon(Icons.refresh),
        );
      },
      child: CupertinoActivityIndicator(),
    );
  }

  void _onRefreshTap(BuildContext context, WidgetRef ref) {
    ref.invalidate(provider);
  }
}
