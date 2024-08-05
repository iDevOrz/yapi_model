import 'package:flutter/material.dart';
import 'package:yapi_model/domain/project_config.dart';
import 'package:yapi_model/routers/go_routers.dart';

class HomeProjectItemView extends StatelessWidget {
  const HomeProjectItemView(
      {super.key, required this.data, this.onDeletePressed});

  final ProjectConfig data;

  final VoidCallback? onDeletePressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _onTap(context),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(child: Text(data.name ?? "unknown")),
              IconButton(
                  onPressed: onDeletePressed,
                  icon: const Icon(
                    Icons.delete,
                    color: Colors.red,
                  ))
            ],
          ),
        ),
      ),
    );
  }

  void _onTap(BuildContext context) {
    ProjectScreenRoute(id: data.id).push(context);
  }
}
