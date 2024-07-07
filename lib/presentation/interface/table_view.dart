import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

typedef TableRowBuilder<T> = (String tabName, String Function(T rowData));

class TableView<T> extends StatelessWidget {
  const TableView(
      {super.key,
      required this.dataSource,
      required this.rowBuilders,
      required this.header});

  final String header;

  final List<T> dataSource;

  final List<TableRowBuilder<T>> rowBuilders;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(header, style: Theme.of(context).textTheme.titleMedium),
          Table(
            border: const TableBorder.symmetric(
                inside: BorderSide(color: Colors.grey)),
            children: <TableRow>[
              TableRow(
                  decoration: const BoxDecoration(color: Colors.grey),
                  children: rowBuilders.map((builder) {
                    final (name, _) = builder;
                    return _buildChild(context, name, isHeader: true);
                  }).toList()),
              ...dataSource.mapIndexed((index, data) {
                return TableRow(
                    decoration: BoxDecoration(
                        color:
                            index % 2 == 0 ? Colors.white70 : Colors.white38),
                    children: rowBuilders.map((builder) {
                      final (_, valueBuilder) = builder;
                      final value = valueBuilder(dataSource[index]);
                      return _buildChild(context, value);
                    }).toList());
              })
            ],
          )
        ],
      ),
    );
  }

  Widget _buildChild(BuildContext context, String value,
      {bool isHeader = false}) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Text(
        value,
        style: isHeader
            ? const TextStyle(
                fontWeight: FontWeight.bold, color: Colors.white70)
            : null,
      ),
    );
  }
}
