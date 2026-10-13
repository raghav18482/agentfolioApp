import 'package:agentfolio/core/error/failure.dart';

/// What a screen section is showing. Every data surface handles all four.
sealed class ViewState<T> {
  const ViewState();

  /// The data on screen, if any, including while it refreshes.
  T? get dataOrNull => switch (this) {
    ViewData<T>(:final data) => data,
    _ => null,
  };

  bool get isBusy => switch (this) {
    ViewLoading<T>() => true,
    ViewData<T>(:final refreshing) => refreshing,
    _ => false,
  };
}

/// Nothing requested yet.
final class ViewIdle<T> extends ViewState<T> {
  const ViewIdle();
}

/// First load, nothing to show: render a skeleton.
final class ViewLoading<T> extends ViewState<T> {
  const ViewLoading();
}

/// Data to show. [refreshing] means a newer copy is on its way: keep showing
/// this one, with a quiet progress hint, never a spinner over it.
/// [refreshFailure] is set when that refresh failed: the data stays and a
/// non-blocking notice explains it may be out of date.
final class ViewData<T> extends ViewState<T> {
  const ViewData(this.data, {this.refreshing = false, this.refreshFailure, this.updatedAt});

  final T data;
  final bool refreshing;
  final Failure? refreshFailure;
  final DateTime? updatedAt;

  ViewData<T> copyWith({bool? refreshing, Failure? refreshFailure, bool clearFailure = false}) =>
      ViewData(
        data,
        refreshing: refreshing ?? this.refreshing,
        refreshFailure: clearFailure ? null : (refreshFailure ?? this.refreshFailure),
        updatedAt: updatedAt,
      );
}

/// The first load failed and there is nothing to show: render the error with
/// a retry.
final class ViewError<T> extends ViewState<T> {
  const ViewError(this.failure);

  final Failure failure;
}
