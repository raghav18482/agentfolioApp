/// One Server-Sent Event: its name (`message` when unnamed) and data.
class SseEvent {
  const SseEvent(this.event, this.data);

  final String event;
  final String data;

  @override
  String toString() => 'SseEvent($event, $data)';
}

/// Turns a `text/event-stream` body, arriving in arbitrary chunks, into
/// events. Follows the WHATWG rules the server's frames rely on:
/// * lines end in `\n`, `\r\n` or `\r`, and a chunk may end mid-line;
/// * `event:` names the event, `data:` lines join with `\n`;
/// * a blank line dispatches; an event with no data is dropped;
/// * lines starting `:` are comments (the server's heartbeat pings).
class SseParser {
  final _buffer = StringBuffer();
  String _event = '';
  final _data = <String>[];
  bool _lastWasCr = false;

  /// Feeds one chunk; returns the events it completed.
  List<SseEvent> add(String chunk) {
    final events = <SseEvent>[];
    for (var i = 0; i < chunk.length; i++) {
      final c = chunk[i];
      if (c == '\n' && _lastWasCr) {
        _lastWasCr = false; // the \n of a \r\n already handled
        continue;
      }
      _lastWasCr = c == '\r';
      if (c == '\n' || c == '\r') {
        final event = _line(_buffer.toString());
        _buffer.clear();
        if (event != null) events.add(event);
      } else {
        _buffer.write(c);
      }
    }
    return events;
  }

  SseEvent? _line(String line) {
    if (line.isEmpty) {
      if (_data.isEmpty) {
        _event = '';
        return null;
      }
      final event = SseEvent(_event.isEmpty ? 'message' : _event, _data.join('\n'));
      _event = '';
      _data.clear();
      return event;
    }
    if (line.startsWith(':')) return null;
    final colon = line.indexOf(':');
    final field = colon < 0 ? line : line.substring(0, colon);
    var value = colon < 0 ? '' : line.substring(colon + 1);
    if (value.startsWith(' ')) value = value.substring(1);
    switch (field) {
      case 'event':
        _event = value;
      case 'data':
        _data.add(value);
    }
    return null;
  }
}
