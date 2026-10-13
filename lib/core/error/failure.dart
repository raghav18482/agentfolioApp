/// Everything that can go wrong, as the UI needs to tell it apart.
///
/// [message] is what the user sees. It is the server's own `{error}` /
/// `{detail}` text whenever the server sent one, so wording stays consistent
/// with the web app.
sealed class Failure {
  const Failure(this.message);

  final String message;
}

/// The request never reached the server: offline, DNS, TLS, refused.
final class NetworkFailure extends Failure {
  const NetworkFailure([super.message = 'Could not reach the server. Check your connection.']);
}

final class TimeoutFailure extends Failure {
  const TimeoutFailure([super.message = 'The server took too long to answer. Try again.']);
}

/// The session ended. The session layer reacts to this; screens rarely do.
final class UnauthorizedFailure extends Failure {
  const UnauthorizedFailure([super.message = 'Your session has ended. Please sign in again.']);
}

/// A 403 from a premium-only endpoint. Expected state, not an error to alarm on.
final class PremiumRequiredFailure extends Failure {
  const PremiumRequiredFailure([super.message = 'This feature needs Premium.']);
}

/// A 429. [retryAfter] comes from the `Retry-After` header when present.
final class RateLimitedFailure extends Failure {
  const RateLimitedFailure(super.message, {this.retryAfter});

  final Duration? retryAfter;
}

/// The broker rejected or failed the call (502/503): stale stored credentials,
/// broker downtime or its own rate limit.
final class BrokerFailure extends Failure {
  const BrokerFailure(super.message, {this.statusCode});

  final int? statusCode;
}

/// One input was wrong (400/409). [field] names it when the server says which.
final class ValidationFailure extends Failure {
  const ValidationFailure(super.message, {this.field});

  final String? field;
}

/// The server has nothing to show for this request, and retrying will not
/// change that: an ETF with no fundamentals, a stock listed too recently for
/// indicators, an instrument the broker does not know (404). Shown as a calm
/// empty state, never as an error.
final class UnavailableFailure extends Failure {
  const UnavailableFailure(super.message);
}

final class ServerFailure extends Failure {
  const ServerFailure(super.message, {this.statusCode});

  final int? statusCode;
}

/// A write whose outcome is unknown: the connection dropped after the request
/// left. The caller must reconcile from the server and never resubmit blindly;
/// for an order approval, resubmitting could place the order twice.
final class UnknownOutcomeFailure extends Failure {
  const UnknownOutcomeFailure([
    super.message = 'We lost the connection before the server answered. Checking what happened…',
  ]);
}

/// The request was cancelled because its screen went away or the session
/// changed. Never shown to the user.
final class CancelledFailure extends Failure {
  const CancelledFailure() : super('Cancelled');
}

/// The server answered with something we could not read. Reported, since it
/// means the API contract changed under us.
final class ParseFailure extends Failure {
  const ParseFailure([super.message = 'Something went wrong reading the response.']);
}

final class UnexpectedFailure extends Failure {
  const UnexpectedFailure([super.message = 'Something went wrong. Please try again.']);
}
