import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yapi_model/common/widgets/async_value_widget.dart';
import 'package:yapi_model/domain/interface_info.dart';
import 'package:yapi_model/presentation/interface_controller.dart';

class InterfaceScreen extends StatelessWidget {
  const InterfaceScreen({super.key, required this.id});

  final int id;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Consumer(
        builder: (context, ref, child) {
          final info = ref.watch(interfaceControllerProvider(id: id));
          return AsyncValueWidget(
            value: info,
            data: (value) => _buildInfoValue(context, info: value),
          );
        },
      ),
    );
  }

  Widget _buildInfoValue(BuildContext context, {required InterfaceInfo info}) {
    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text("接口名称：${info.title}"),
          Text("接口路径：${info.path}"),
        ],
      ),
    );
  }
}
