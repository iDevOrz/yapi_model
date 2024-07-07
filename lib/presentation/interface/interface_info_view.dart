import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yapi_model/domain/interface_info.dart';
import 'package:yapi_model/domain/mock_path.dart';

import 'body_tree_view.dart';
import 'table_view.dart';

class InterfaceInfoView extends StatelessWidget {
  const InterfaceInfoView({super.key, required this.info});

  final InterfaceInfo info;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildHeadline(context, header: "基本信息"),
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
        Consumer(
          builder: (context, ref, child) {
            final mockPath = ref.watch(mockPathProvider(interface: info));
            return Text(mockPath.fullPath);
          },
        ),
        _buildHeadline(context, header: "请求参数"),
        TableView<ReqHeaders>(
            header: "Header",
            dataSource: info.reqHeaders ?? [],
            rowBuilders: [
              ("参数名称", (ReqHeaders header) => header.name ?? ""),
              ("参数值", (ReqHeaders header) => header.value ?? ""),
              ("是否必须", (ReqHeaders header) => header.required ?? ""),
              ("示例", (ReqHeaders header) => header.example ?? "")
            ]),
        TableView<ReqQuery>(
            header: "Query",
            dataSource: info.reqQuery ?? [],
            rowBuilders: [
              ("参数名称", (ReqQuery query) => query.name ?? ""),
              ("是否必须", (ReqQuery query) => query.required ?? ""),
              ("示例", (ReqQuery query) => query.example ?? ""),
              ("备注", (ReqQuery query) => query.desc ?? ""),
            ]),
        if (info.reqBodyOther != null)
          BodyTreeView(
            header: 'Body',
            body: Body.fromJson(jsonDecode(info.reqBodyOther!)),
          ),
        _buildHeadline(context, header: "返回数据"),
        if (info.resBody != null)
          BodyTreeView(
            header: '返回值',
            body: Body.fromJson(jsonDecode(info.resBody!)),
          )
      ],
    );
  }

  Widget _buildHeadline(BuildContext context, {required String header}) {
    return Text(header, style: Theme.of(context).textTheme.headlineMedium);
  }
}
