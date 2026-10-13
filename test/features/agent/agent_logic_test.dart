import 'package:agentfolio/features/agent/domain/agent_logic.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/fake_agent_repository.dart';

void main() {
  group('approval commands match the server exactly', () {
    test('APPROVE / REJECT with an 8–16 hex id, any case', () {
      final a = parseApprovalCommand('  approve A1B2C3D4  ')!;
      expect(a.verb, ApprovalVerb.approve);
      expect(a.proposalId, 'a1b2c3d4');
      expect(parseApprovalCommand('REJECT 0123456789abcdef')!.verb, ApprovalVerb.reject);
    });

    test('anything the server would pass to the agent instead is not a command', () {
      for (final text in [
        'APPROVE',
        'APPROVE a1b2c3', // too short
        'APPROVE a1b2c3d4e5f6a7b8c9', // too long
        'APPROVE xyz12345', // not hex
        'please APPROVE a1b2c3d4',
        'APPROVE a1b2c3d4 now',
        'Should I approve a1b2c3d4?',
      ]) {
        expect(parseApprovalCommand(text), isNull, reason: text);
      }
    });
  });

  test('history shows what was typed, not the note the server added for the agent', () {
    expect(
      historyText(
        '[System: Proposal a1b2c3d4 APPROVED and executed. Order ID: 9] APPROVE a1b2c3d4',
      ),
      'APPROVE a1b2c3d4',
    );
    expect(
      historyText('[System: Approval failed: Proposal [x] expired] reject a1b2c3d4'),
      'reject a1b2c3d4',
    );
    // A user who types brackets themselves is left alone.
    expect(historyText('[System: hi] what is my P&L?'), '[System: hi] what is my P&L?');
  });

  test('threads group by local calendar day, newest first', () {
    final now = DateTime(2026, 10, 12, 9);
    final groups = groupThreads([
      thread(1, 'old', at: DateTime(2026, 9)),
      thread(2, 'this morning', at: DateTime(2026, 10, 12, 8)),
      thread(3, 'late last night', at: DateTime(2026, 10, 11, 23, 50)),
      thread(4, 'earlier today', at: DateTime(2026, 10, 12, 0, 5)),
      thread(5, 'tuesday', at: DateTime(2026, 10, 7)),
    ], now);
    expect(
      [for (final (age, list) in groups) '${age.name}: ${list.map((t) => t.title).join(', ')}'],
      [
        'today: this morning, earlier today',
        'yesterday: late last night',
        'thisWeek: tuesday',
        'older: old',
      ],
    );
  });
}
