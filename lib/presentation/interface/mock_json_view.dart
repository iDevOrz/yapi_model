import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yapi_model/common/widgets/async_value_widget.dart';
import 'package:yapi_model/domain/interface_info.dart';
import 'package:yapi_model/domain/mock_json.dart';
import 'package:yapi_model/presentation/interface/json_view.dart';

class MockJsonView extends StatelessWidget {
  const MockJsonView({super.key, required this.interface});

  final InterfaceInfo interface;

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final asyncJson = ref.watch(mockJsonProvider(interface));
        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text("Mock数据", style: Theme.of(context).textTheme.headlineMedium),
            AsyncValueWidget(
                value: asyncJson, data: (json) => JsonView(json: json)),
          ],
        );
      },
    );
  }
}
