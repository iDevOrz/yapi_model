import 'package:flutter/material.dart';
import 'package:yapi_model/domain/interface_info.dart';
import 'package:yapi_model/presentation/interface/table_view.dart';

class BodyTreeView extends StatelessWidget {
  const BodyTreeView({super.key, required this.header, required this.body});

  final String header;

  final Body body;

  List<TableRowBuilder<MapEntry<String, Body>>> get rowBuilders => [
        ("名称", (map) => map.key),
        ("标题", (map) => map.value.title),
        (
          "是否必须",
          (map) => (body.required?.contains(map.key) ?? false).toString()
        ),
        ("类型", (map) => map.value.type.name),
        ("备注", (map) => map.value.description),
      ];

  @override
  Widget build(BuildContext context) {
    return TableView<MapEntry<String, Body>>(
        dataSource: body.properties?.entries.toList() ?? [],
        rowBuilders: rowBuilders,
        header: header);
  }
}
