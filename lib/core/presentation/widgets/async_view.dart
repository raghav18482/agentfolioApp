import 'package:agentfolio/core/presentation/theme/app_motion.dart';
import 'package:agentfolio/core/presentation/view_state.dart';
import 'package:agentfolio/core/presentation/widgets/error_view.dart';
import 'package:agentfolio/core/presentation/widgets/skeleton.dart';
import 'package:flutter/material.dart';

/// Renders a [ViewState] the same way on every screen: a skeleton while first
/// loading, the error with Retry if that failed, an empty state when there is
/// nothing, and the data otherwise.
///
/// Phases cross-fade. Refreshes of data already on screen do not: the data
/// stays put, so the screen never flickers on pull-to-refresh.
class AsyncView<T> extends StatelessWidget {
  const AsyncView({
    required this.state,
    required this.builder,
    required this.skeleton,
    required this.onRetry,
    required this.retryTrackId,
    super.key,
    this.isEmpty,
    this.empty,
  });

  final ViewState<T> state;
  final Widget Function(BuildContext context, T data) builder;

  /// Laid out like the real content, wrapped in a [Shimmer] for you.
  final Widget skeleton;
  final VoidCallback onRetry;
  final String retryTrackId;
  final bool Function(T data)? isEmpty;
  final WidgetBuilder? empty;

  @override
  Widget build(BuildContext context) {
    final (Key key, Widget child) = switch (state) {
      ViewIdle<T>() || ViewLoading<T>() => (const ValueKey('loading'), Shimmer(child: skeleton)),
      ViewError<T>(:final failure) => (
        const ValueKey('error'),
        ErrorView(failure: failure, onRetry: onRetry, retryTrackId: retryTrackId),
      ),
      ViewData<T>(:final data) when empty != null && (isEmpty?.call(data) ?? false) => (
        const ValueKey('empty'),
        empty!(context),
      ),
      ViewData<T>(:final data) => (const ValueKey('data'), builder(context, data)),
    };

    return AnimatedSwitcher(
      duration: AppMotion.of(context, AppMotion.medium),
      switchInCurve: AppMotion.enter,
      switchOutCurve: AppMotion.exit,
      child: KeyedSubtree(key: key, child: child),
    );
  }
}
