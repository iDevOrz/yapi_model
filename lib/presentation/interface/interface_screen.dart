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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("信息信息"),
      ),
      body: Consumer(
        builder: (context, ref, child) {
          final asyncInfo = ref.watch(interfaceControllerProvider(id: id));
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
}
