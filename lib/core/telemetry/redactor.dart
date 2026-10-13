/// Scrubs telemetry properties before they leave the facade.
///
/// The rules are deliberately blunt. This is a trading app: a false positive
/// costs one analytics property, while a false negative ships a password or a
/// phone number to a third party.
class Redactor {
  const Redactor();

  static const redacted = '[redacted]';
  static const _maxStringLength = 120;
  static const _maxListLength = 20;

  /// Key fragments that mark a secret or personal value. Matched against the
  /// key with separators removed, so `api_key`, `apiKey` and `API-Key` all hit.
  static const _secretFragments = [
    'password',
    'passwd',
    'secret',
    'totp',
    'token',
    'cookie',
    'authorization',
    'apikey',
    'phone',
    'whatsapp',
    'mobile',
    'email',
    'clientid',
    'clientcode',
  ];

  /// Whole key words that carry user-written text or money.
  static const _sensitiveWords = {
    'pin',
    'otp',
    'message',
    'question',
    'prompt',
    'text',
    'body',
    'reply',
    'answer',
    'amount',
    'value',
    'price',
    'pnl',
    'invested',
    'cash',
    'balance',
    'ltp',
    'qty',
    'quantity',
  };

  static final _phonePattern = RegExp(r'\+?\d[\d\s-]{8,}\d');
  static final _emailPattern = RegExp(r'[\w.+-]+@[\w-]+\.[\w.]+');

  Map<String, Object?> properties(Map<String, Object?> input) => {
    for (final entry in input.entries)
      if (entry.value != null)
        entry.key: isSensitiveKey(entry.key) ? redacted : _value(entry.value),
  };

  /// Masks phone numbers and emails inside free text such as log lines.
  String text(String input) {
    final masked = input.replaceAll(_emailPattern, redacted).replaceAll(_phonePattern, redacted);
    return masked.length > _maxStringLength * 4
        ? '${masked.substring(0, _maxStringLength * 4)}…'
        : masked;
  }

  bool isSensitiveKey(String key) {
    final compact = key.toLowerCase().replaceAll(RegExp('[^a-z0-9]'), '');
    if (_secretFragments.any(compact.contains)) return true;
    return _words(key).any(_sensitiveWords.contains);
  }

  Object? _value(Object? value) => switch (value) {
    final String s => _string(s),
    final Map<String, Object?> m => properties(m),
    final Iterable<Object?> list => list.take(_maxListLength).map(_value).toList(),
    final num n => n,
    final bool b => b,
    final Enum e => e.name,
    _ => _string(value.toString()),
  };

  String _string(String s) {
    final masked = text(s);
    return masked.length > _maxStringLength ? '${masked.substring(0, _maxStringLength)}…' : masked;
  }

  /// `apiKey` → [api, key]; `whatsapp_number` → [whatsapp, number].
  static Iterable<String> _words(String key) => key
      .replaceAllMapped(RegExp('([a-z0-9])([A-Z])'), (m) => '${m[1]}_${m[2]}')
      .toLowerCase()
      .split(RegExp('[^a-z0-9]+'))
      .where((w) => w.isNotEmpty);
}
