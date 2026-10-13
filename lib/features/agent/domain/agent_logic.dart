import 'package:agentfolio/features/agent/domain/entities/agent.dart';

/// `APPROVE <id>` / `REJECT <id>` typed into the trading chat. The server
/// carries these out itself, before the agent sees them: an approval places
/// a real order.
enum ApprovalVerb { approve, reject }

class ApprovalCommand {
  const ApprovalCommand(this.verb, this.proposalId);

  final ApprovalVerb verb;
  final String proposalId;
}

/// Exactly the server's patterns (`web/routers/agent.py`), so the app asks
/// for confirmation on precisely the messages the server would act on.
final _approve = RegExp(r'^APPROVE\s+([a-f0-9]{8,16})$', caseSensitive: false);
final _reject = RegExp(r'^REJECT\s+([a-f0-9]{8,16})$', caseSensitive: false);

ApprovalCommand? parseApprovalCommand(String text) {
  final message = text.trim();
  if (_approve.firstMatch(message) case final m?) {
    return ApprovalCommand(ApprovalVerb.approve, m.group(1)!.toLowerCase());
  }
  if (_reject.firstMatch(message) case final m?) {
    return ApprovalCommand(ApprovalVerb.reject, m.group(1)!.toLowerCase());
  }
  return null;
}

/// The server stores an approval as `[System: <result>] APPROVE <id>`, so
/// the agent knows what happened. History shows what the user typed.
final _systemPrefix = RegExp(
  r'^\[System: .*\] ((?:APPROVE|REJECT)\s+[a-f0-9]{8,16})$',
  caseSensitive: false,
  dotAll: true,
);

String historyText(String text) {
  final trimmed = text.trim();
  return _systemPrefix.firstMatch(trimmed)?.group(1) ?? trimmed;
}

/// What the server titles a thread before its first message.
const defaultThreadTitle = 'New conversation';

/// The longest message accepted: generous for a question, short of pasting
/// a document into a model that bills per token.
const maxMessageLength = 4000;

enum ThreadAge { today, yesterday, thisWeek, older }

/// Threads by how recently they were used, newest first within each, for the
/// conversation list. Days are the user's local calendar days.
List<(ThreadAge, List<ChatThread>)> groupThreads(List<ChatThread> threads, DateTime now) {
  final today = DateTime(now.year, now.month, now.day);
  ThreadAge ageOf(ChatThread t) {
    final at = (t.updatedAt ?? t.createdAt)?.toLocal();
    if (at == null) return ThreadAge.older;
    final day = DateTime(at.year, at.month, at.day);
    final days = today.difference(day).inDays;
    if (days <= 0) return ThreadAge.today;
    if (days == 1) return ThreadAge.yesterday;
    if (days < 7) return ThreadAge.thisWeek;
    return ThreadAge.older;
  }

  DateTime sortKey(ChatThread t) =>
      t.updatedAt ?? t.createdAt ?? DateTime.fromMillisecondsSinceEpoch(0);

  final sorted = [...threads]..sort((a, b) => sortKey(b).compareTo(sortKey(a)));
  final groups = <ThreadAge, List<ChatThread>>{};
  for (final t in sorted) {
    groups.putIfAbsent(ageOf(t), () => []).add(t);
  }
  return [
    for (final age in ThreadAge.values)
      if (groups[age] case final list?) (age, list),
  ];
}
