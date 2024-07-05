import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yapi_model/common/widgets/error_state_view.dart';

class AsyncValueWidget<T> extends StatelessWidget {
  const AsyncValueWidget({
    super.key,
    required this.value,
    required this.data,
    this.onErrorActionTap,
    this.errorActionText,
  });

  final AsyncValue<T> value;
  final Widget Function(T) data;

  final GestureTapCallback? onErrorActionTap;

  final String? errorActionText;

  @override
  Widget build(BuildContext context) {
    return value.when(
      data: data,
      error: (error, st) {
        debugPrintStack(label: error.toString(), stackTrace: st);
        return Center(
            child: ErrorStateView(
          error: error,
          onActionTap: onErrorActionTap,
          actionText: errorActionText,
        ));
      },
      loading: () => const Center(child: CircularProgressIndicator()),
    );
  }
}

class AsyncValueSliverWidget<T> extends StatelessWidget {
  const AsyncValueSliverWidget({
    super.key,
    required this.value,
    required this.data,
    this.onErrorActionTap,
    this.errorActionText,
  });

  final AsyncValue<T> value;
  final Widget Function(T) data;

  final GestureTapCallback? onErrorActionTap;

  final String? errorActionText;

  @override
  Widget build(BuildContext context) {
    return value.when(
      data: data,
      loading: () => const SliverFillRemaining(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      ),
      error: (e, st) {
        debugPrintStack(label: e.toString(), stackTrace: st);
        return SliverFillRemaining(
          child: Center(
            child: ErrorStateView(
              error: e,
              onActionTap: onErrorActionTap,
              actionText: errorActionText,
            ),
          ),
        );
      },
    );
  }
}
