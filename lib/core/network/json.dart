/// Decoding helpers for data sources.
///
/// A body of the wrong shape throws a [TypeError] here, which `guardApi`
/// reports as a contract change and turns into a `ParseFailure`.
typedef JsonMap = Map<String, dynamic>;

JsonMap asJsonMap(Object? json) => json! as JsonMap;

/// The server said "nothing to show" with a 200 and an `error` text, as the
/// research and prediction endpoints do for thin data. `guardApi` turns this
/// into an `UnavailableFailure` carrying the server's words.
class UnavailableDataException implements Exception {
  const UnavailableDataException(this.message);

  final String message;

  @override
  String toString() => 'UnavailableDataException: $message';
}

/// [asJsonMap] for endpoints that report "no data" as a 200 with
/// `{error: "..."}` rather than an error status.
JsonMap asDataMap(Object? json) {
  final map = asJsonMap(json);
  final error = map['error'];
  if (error is String && error.trim().isNotEmpty) throw UnavailableDataException(error.trim());
  return map;
}

List<T> asJsonList<T>(Object? json, T Function(JsonMap item) decode) =>
    (json! as List<dynamic>).map((item) => decode(item as JsonMap)).toList();

/// For endpoints whose answer we do not read, only its success.
void ignoreBody(Object? _) {}
