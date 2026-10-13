import 'package:agentfolio/core/network/sse.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  List<String> parse(List<String> chunks) {
    final parser = SseParser();
    return [
      for (final c in chunks)
        for (final e in parser.add(c)) '${e.event}=${e.data}',
    ];
  }

  test("the server's frames: named events, heartbeats ignored", () {
    expect(
      parse([
        'event: subscribed\ndata: {"symbols":[]}\n\n',
        ': ping\n\n',
        'event: tick\ndata: {"ltp":1}\n\n',
      ]),
      ['subscribed={"symbols":[]}', 'tick={"ltp":1}'],
    );
  });

  test(r'a frame split anywhere, even between \r and \n, arrives once', () {
    expect(parse(['event: ti', 'ck\r', '\ndata: {"lt', 'p":2}\r\n', '\r\n']), ['tick={"ltp":2}']);
  });

  test('data lines join, unnamed events are messages, empty events dropped', () {
    expect(parse(['data: a\ndata: b\n\nevent: x\n\ndata:c\n\n']), ['message=a\nb', 'message=c']);
  });
}
