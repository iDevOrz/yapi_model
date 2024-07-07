import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yapi_model/domain/group.dart';
import 'package:yapi_model/presentation/project/group_list_controller.dart';
import 'package:yapi_model/routers/go_routers.dart';

class GroupListItemView extends StatelessWidget {
  const GroupListItemView({super.key, required this.data});

  final Group data;

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final initiallyExpanded = ref.watch(groupListSearchProvider).isNotEmpty;
        return ExpansionTile(
          title: Text(data.name.toString()),
          subtitle: Text("共 ${data.list.length} 个接口"),
          initiallyExpanded: initiallyExpanded,
          children: data.list
              .map(
                  (interface) => _buildInterface(context, interface: interface))
              .toList(),
        );
      },
    );

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(data.name.toString()),
            const SizedBox(height: 6),
            Text(data.list.length.toString()),
          ],
        ),
      ),
    );
  }

  Widget _buildInterface(BuildContext context, {required Interface interface}) {
    return InkWell(
      onTap: () => _onInterfaceTap(context, interface: interface),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white70,
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.all(6),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(interface.title),
            Text(interface.path),
          ],
        ),
      ),
    );
  }

  void _onInterfaceTap(BuildContext context, {required Interface interface}) {
    InterfaceScreenRoute(id: interface.id).push(context);
  }
}
