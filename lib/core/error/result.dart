import 'package:agentfolio/core/error/failure.dart';

/// The outcome of a repository call: a value or a [Failure], never a throw.
///
/// Repositories catch at the boundary so view models deal in values and the
/// compiler forces both branches to be handled.
sealed class Result<T> {
  const Result();

  bool get isSuccess => this is Success<T>;

  T? get valueOrNull => switch (this) {
    Success(:final value) => value,
    Err() => null,
  };

  Failure? get failureOrNull => switch (this) {
    Success() => null,
    Err(:final failure) => failure,
  };

  R fold<R>(R Function(T value) onSuccess, R Function(Failure failure) onFailure) => switch (this) {
    Success(:final value) => onSuccess(value),
    Err(:final failure) => onFailure(failure),
  };

  Result<R> map<R>(R Function(T value) transform) => switch (this) {
    Success(:final value) => Success(transform(value)),
    Err(:final failure) => Err(failure),
  };
}

final class Success<T> extends Result<T> {
  const Success(this.value);

  final T value;
}

final class Err<T> extends Result<T> {
  const Err(this.failure);

  final Failure failure;
}
