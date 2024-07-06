import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yapi_model/common/widgets/async_value_widget.dart';
import 'package:yapi_model/domain/code_util.dart';
import 'package:yapi_model/domain/interface_info.dart';
import 'package:yapi_model/presentation/interface/interface_controller.dart';
import 'package:yapi_model/presentation/interface/model_view.dart';

import 'json_view.dart';

class InterfaceScreen extends StatelessWidget {
  const InterfaceScreen({super.key, required this.id});

  final int id;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("信息信息"),
      ),
      body: CustomScrollView(
        slivers: [
          Consumer(
            builder: (context, ref, child) {
              final info = ref.watch(interfaceControllerProvider(id: id));
              return AsyncValueSliverWidget(
                value: info,
                data: (value) => SliverToBoxAdapter(
                    child: _buildInfoValue(context, info: value)),
              );
            },
          )
        ],
      ),
    );
  }

  Widget _buildInfoValue(BuildContext context, {required InterfaceInfo info}) {
    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildHeadline(context, header: "基本信息"),
          Text(
            "接口名称：${info.title}",
            style: TextStyle(color: Colors.blue[300]),
          ),
          Text(
            "创建人：${info.username}",
            style: TextStyle(color: Colors.blue[300]),
          ),
          Text(
            "状态：${info.status}",
            style: TextStyle(color: Colors.blue[300]),
          ),
          Text(
            "更新时间：${info.upTime}",
            style: TextStyle(color: Colors.blue[300]),
          ),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(color: Colors.green[200]),
                child: Text(info.method.toString()),
              ),
              const SizedBox(width: 2),
              Flexible(child: Text(info.path))
            ],
          ),
          _buildHeadline(context, header: "请求参数"),
          _buildData(context,
              title: "Header", value: info.reqHeaders.toString()),
          _buildData(context, title: "Query", value: info.reqQuery.toString()),
          _buildData(context,
              title: "Request Body", value: info.reqBodyOther.toString()),
          _buildHeadline(context, header: "返回数据"),
          _buildData(context,
              title: "Response Body", value: info.resBody.toString()),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: JsonView(json: info.resBody.toString())),
              SizedBox(width: 20),
              Expanded(
                  child: ModelView(models: CodeUtil.gen(info.resBody ?? "{}")))
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHeadline(BuildContext context, {required String header}) {
    return Text(header, style: Theme.of(context).textTheme.headlineMedium);
  }

  Widget _buildData(BuildContext context,
      {required String title, required String value}) {
    return Card(
      color: Colors.white54,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(title, style: Theme.of(context).textTheme.titleMedium),
            Text(value, style: Theme.of(context).textTheme.bodySmall),
          ],
        ),
      ),
    );
  }

// Widget _buildJsonView(BuildContext context,{required String json}) {
//   return CodeField
// }
}
