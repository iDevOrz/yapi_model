import 'package:flutter/material.dart';

class ErrorStateView extends StatelessWidget {
  const ErrorStateView({
    super.key,
    required this.error,
    this.onActionTap,
    this.actionText,
  });

  final Object error;

  final GestureTapCallback? onActionTap;

  final String? actionText;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline_outlined),
          const SizedBox(height: 12),
          Text(error.toString()),
          const SizedBox(height: 20),
          if (onActionTap != null)
            ElevatedButton(
              onPressed: onActionTap,
              child: Text(actionText ?? "Retry"),
            )
        ],
      ),
    );
  }
}
