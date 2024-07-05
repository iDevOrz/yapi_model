import 'package:flutter/material.dart';
import 'package:yapi_model/domain/project_config.dart';
import 'package:yapi_model/routers/go_routers.dart';

class HomeProjectItemView extends StatelessWidget {
  const HomeProjectItemView({super.key, required this.data});

  final ProjectConfig data;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _onTap(context),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(data.name ?? "unknown"),
        ),
      ),
    );
  }

  void _onTap(BuildContext context) {
    ProjectScreenRoute(id: data.id).push(context);
  }
}
