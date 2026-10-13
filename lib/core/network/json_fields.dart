import 'package:agentfolio/core/utils/format.dart';

/// Tolerant readers for `@JsonKey(fromJson: ...)`. Broker and Yahoo figures
/// arrive as numbers, numeric strings, `"N/A"` or not at all; these read
/// what is there and never invent a value.

double jsonNum(Object? v) => Fmt.parseAmount(v) ?? 0;

/// Null when there is no real number: shown as "—", never as a fake zero.
double? jsonNumOrNull(Object? v) => Fmt.parseAmount(v);

int jsonInt(Object? v) => (Fmt.parseAmount(v) ?? 0).round();

String jsonString(Object? v) => v?.toString() ?? '';

String? jsonStringOrNull(Object? v) {
  final s = v?.toString().trim();
  return s == null || s.isEmpty ? null : s;
}

List<String> jsonStringList(Object? v) => v is List
    ? [
        for (final item in v)
          if (item != null) item.toString(),
      ]
    : const [];

/// A series with gaps, e.g. an indicator before its window fills.
List<double?> jsonNumOrNullList(Object? v) =>
    v is List ? [for (final item in v) Fmt.parseAmount(item)] : const [];
