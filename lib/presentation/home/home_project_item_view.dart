import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yapi_model/data/yapi_repository.dart';
import 'package:yapi_model/domain/project_config.dart';
import 'package:yapi_model/routers/go_routers.dart';

class HomeProjectItemView extends ConsumerWidget {
  const HomeProjectItemView(
      {super.key, required this.data, this.onDeletePressed});

  final ProjectConfig data;

  final VoidCallback? onDeletePressed;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return InkWell(
      onTap: () => _onTap(ref),
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

  Future<void> _onTap(WidgetRef ref) async {
    ref.watch(baseUrlProvider.notifier).state = data.baseUrl;
    ref.watch(tokenProvider.notifier).state = data.token;
    final result = await ref.read(yapiRepositoryProvider).getProject();
    if (ref.context.mounted) {
      ProjectScreenRoute(id: result.data.id).push(ref.context);
    }
  }
}
