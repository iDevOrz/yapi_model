import 'dart:convert';

import 'package:flutter/foundation.dart' show DiagnosticPropertiesBuilder;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart' show DiagnosticsProperty;
import 'package:flutter_riverpod/flutter_riverpod.dart' show Consumer;
import 'package:yapi_model/common/extension/date_convert_extension.dart';
import 'package:yapi_model/data/model/interface_info.dart';
import 'package:yapi_model/data/model/mock_path.dart';

import 'body_tree_view.dart';
import 'table_view.dart';

class InterfaceInfoView extends StatelessWidget {
  const InterfaceInfoView({super.key, required this.info});

  final InterfaceInfo info;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        spacing: 12,
        children: [
          _buildBasicView(context),
          _buildReqHeadersView(context),
          _buildResponseView(context),
        ],
      ),
    );
  }

  Widget _buildHeadline(BuildContext context, {required String header}) {
    return Text(header, style: Theme.of(context).textTheme.headlineMedium);
  }

  Widget _buildSectionViewWrap({required List<Widget> children}) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      spacing: 6,
      children: children,
    );
  }

  /// 基本信息
  Widget _buildBasicView(BuildContext context) {
    return _buildSectionViewWrap(
      children: [
        _buildHeadline(context, header: "基本信息"),
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                color: Colors.green[200],
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(info.method ?? "Unknown"),
            ),
            const SizedBox(width: 4),
            Flexible(child: Text(info.path)),
          ],
        ),
        Text("接口名称：${info.title}", style: TextStyle(color: Colors.blue[300])),
        Text("创建人：${info.username}", style: TextStyle(color: Colors.blue[300])),
        Text("状态：${info.status}", style: TextStyle(color: Colors.blue[300])),
        Text(
          "更新时间：${info.upTime?.format ?? "UnKnown"}",
          style: TextStyle(color: Colors.blue[300]),
        ),
        Consumer(
          builder: (context, ref, child) {
            final mockPath = ref.watch(mockPathProvider(interface: info));
            return Text(
              "Mock path:${mockPath.fullPath}",
              style: TextStyle(color: Colors.blue[300]),
            );
          },
        ),
      ],
    );
  }

  Widget _buildReqHeadersView(BuildContext context) {
    return _buildSectionViewWrap(
      children: [
        _buildHeadline(context, header: "请求参数"),
        TableView<ReqHeaders>(
          header: "Header",
          dataSource: info.reqHeaders ?? [],
          rowBuilders: [
            ("参数名称", (ReqHeaders header) => header.name ?? ""),
            ("参数值", (ReqHeaders header) => header.value ?? ""),
            ("是否必须", (ReqHeaders header) => header.required ?? ""),
            ("示例", (ReqHeaders header) => header.example ?? ""),
          ],
        ),
        TableView<ReqQuery>(
          header: "Query",
          dataSource: info.reqQuery ?? [],
          rowBuilders: [
            ("参数名称", (ReqQuery query) => query.name ?? ""),
            ("是否必须", (ReqQuery query) => query.required ?? ""),
            ("示例", (ReqQuery query) => query.example ?? ""),
            ("备注", (ReqQuery query) => query.desc ?? ""),
          ],
        ),
        ?_buildRequestBodyView(context),
      ],
    );
  }

  /// Waiting Dart 3.8 release
  Widget? _buildRequestBodyView(BuildContext context) {
    if (info.reqBodyOther != null) {
      return BodyTreeView(
        header: 'Body',
        body: Body.fromJson(jsonDecode(info.reqBodyOther!)),
      );
    }
    return null;
  }

  Widget _buildResponseView(BuildContext context) {
    return _buildSectionViewWrap(
      children: [
        _buildHeadline(context, header: "返回数据"),
        if (info.resBody != null)
          BodyTreeView(
            header: '返回值',
            body: Body.fromJson(jsonDecode(info.resBody!)),
          ),
      ],
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<InterfaceInfo>('info', info));
  }
}
