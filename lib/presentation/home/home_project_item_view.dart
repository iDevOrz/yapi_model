import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yapi_model/data/model/project_config.dart';
import 'package:yapi_model/data/yapi_repository.dart';
import 'package:yapi_model/routers/go_routers.dart';

class HomeProjectItemView extends ConsumerWidget {
  const HomeProjectItemView({
    super.key,
    required this.data,
    this.onDeletePressed,
  });

  final ProjectConfig data;

  final ValueChanged<ProjectConfig>? onDeletePressed;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FilledButton.tonal(
      onPressed: () => _onTap(ref),
      child: Row(
        children: [
          Expanded(
            child: Text(
              data.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          IconButton(
            onPressed: () => onDeletePressed?.call(data),
            icon: const Icon(Icons.delete, color: Colors.red),
          ),
        ],
      ),
    );
  }

  Future<void> _onTap(WidgetRef ref) async {
    ref.read(baseUrlProvider.notifier).url = data.baseUrl;
    ref.read(tokenProvider.notifier).token = data.token;
    final result = await ref.read(yapiRepositoryProvider).getProject();
    if (ref.context.mounted) {
      ProjectScreenRoute(id: result.data.id).push(ref.context);
    }
  }
}
