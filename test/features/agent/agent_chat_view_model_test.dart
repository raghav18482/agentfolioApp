import 'dart:async';

import 'package:agentfolio/core/error/failure.dart';
import 'package:agentfolio/core/error/result.dart';
import 'package:agentfolio/core/presentation/view_state.dart';
import 'package:agentfolio/core/storage/prefs.dart';
import 'package:agentfolio/core/telemetry/telemetry.dart';
import 'package:agentfolio/core/telemetry/user_hash.dart';
import 'package:agentfolio/features/agent/domain/entities/agent.dart';
import 'package:agentfolio/features/agent/presentation/view_models/agent_chat_view_model.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/fake_agent_repository.dart';
import '../../helpers/fake_ai.dart';
import '../../helpers/recording_sink.dart';

void main() {
  late Telemetry telemetry;
  late Prefs prefs;
  late FakeAgentRepository repo;

  Future<void> settle() => Future<void>.delayed(Duration.zero);

  setUp(() async {
    (telemetry, _) = await recordingTelemetry();
    prefs = await memoryPrefs();
  });

  Future<AgentChatViewModel> chat({AgentType type = AgentType.finance}) async {
    final vm = AgentChatViewModel(
      type: type,
      agent: repo,
      prefs: prefs,
      userId: 'A123',
      telemetry: telemetry,
    );
    await vm.load();
    await settle();
    return vm;
  }

  List<(ChatRole, String, Delivery)> shown(AgentChatViewModel vm) => [
    for (final m in vm.messages) (m.role, m.text, m.delivery),
  ];

  group('premium', () {
    test('resumes the latest conversation with its history', () async {
      repo = FakeAgentRepository(threads: [thread(1, 'Latest'), thread(2, 'Older')])
        ..history[1] = [said(ChatRole.user, 'Hi'), said(ChatRole.assistant, 'Hello')];
      final vm = await chat();
      expect(vm.activeThreadId, 1);
      expect(vm.history, isA<ViewData<void>>());
      expect(shown(vm), [
        (ChatRole.user, 'Hi', Delivery.delivered),
        (ChatRole.assistant, 'Hello', Delivery.delivered),
      ]);
      expect(repo.calls, ['threads', 'messages:1']);
    });

    test('a new conversation is saved on its first message, not before', () async {
      repo = FakeAgentRepository();
      final vm = await chat();
      expect(vm.activeThreadId, isNull);

      await vm.newConversation();
      expect(repo.calls, isNot(contains('create')));
      expect(repo.calls, isNot(contains('reset')));

      await vm.send('How is my portfolio?');
      expect(vm.activeThreadId, 100);
      expect(repo.calls, containsAllInOrder(['create', 'send:100:How is my portfolio?']));
      expect(shown(vm), [
        (ChatRole.user, 'How is my portfolio?', Delivery.delivered),
        (ChatRole.assistant, 'Reply to: How is my portfolio?', Delivery.delivered),
      ]);
      // Already on screen: no history fetch for the thread just made.
      expect(repo.calls, isNot(contains('messages:100')));
    });

    test('if the thread cannot be made, nothing is sent and the message says so', () async {
      repo = FakeAgentRepository()..createFailure = const Err(NetworkFailure());
      final vm = await chat();
      await vm.send('Hello');
      expect(repo.calls.where((c) => c.startsWith('send')), isEmpty);
      expect(shown(vm), [(ChatRole.user, 'Hello', Delivery.failed)]);
      expect(vm.busy, isFalse);
    });

    test('switching threads keeps each one, and a reply lands where it was sent', () async {
      repo = FakeAgentRepository(threads: [thread(1, 'One'), thread(2, 'Two')])
        ..history[2] = [said(ChatRole.user, 'Earlier')]
        ..gate = Completer();
      final vm = await chat();
      final sending = vm.send('Question for one');
      await settle();
      expect(vm.answeringHere, isTrue);

      vm.openThread(2);
      await settle();
      expect(vm.answeringHere, isFalse);
      expect(shown(vm).single.$2, 'Earlier');

      repo.gate!.complete();
      await sending;
      expect(shown(vm).single.$2, 'Earlier');
      vm.openThread(1);
      expect(shown(vm).last.$2, 'Reply to: Question for one');
    });

    test('deleting the open conversation leaves a blank one', () async {
      repo = FakeAgentRepository(threads: [thread(1, 'One'), thread(2, 'Two')]);
      final vm = await chat();
      await vm.delete(1);
      expect(vm.activeThreadId, isNull);
      expect(vm.messages, isEmpty);
      expect(vm.threads.data!.threads.map((t) => t.id), [2]);
    });

    test('renaming squeezes the whitespace a user might type', () async {
      repo = FakeAgentRepository(threads: [thread(1, 'One')]);
      final vm = await chat();
      await vm.rename(1, '  Tax   loss\nideas ');
      expect(repo.calls, contains('rename:1:Tax loss ideas'));
      expect(vm.threads.data!.threads.single.title, 'Tax loss ideas');
    });
  });

  group('not premium', () {
    test('talks in the unsaved conversation, and New chat tells the server', () async {
      repo = FakeAgentRepository(premium: false);
      final vm = await chat();
      await vm.send('Hi');
      expect(repo.calls, contains('send:-:Hi'));
      expect(repo.calls, isNot(contains('create')));

      await vm.newConversation();
      expect(vm.messages, isEmpty);
      expect(repo.calls.last, 'reset');
    });

    test('nothing is sent before the server says whether history is kept', () async {
      repo = FakeAgentRepository(premium: false);
      final vm = AgentChatViewModel(
        type: AgentType.finance,
        agent: repo,
        prefs: prefs,
        userId: 'A123',
        telemetry: telemetry,
      );
      expect(vm.ready, isFalse);
      await vm.send('Too early');
      expect(repo.calls, isEmpty);
    });

    test('if the thread list fails, chat still works, unsaved', () async {
      repo = FakeAgentRepository()..threadsFailure = const Err(ServerFailure('down'));
      final vm = await chat();
      expect(vm.ready, isTrue);
      await vm.send('Hi');
      expect(repo.calls.last, 'send:-:Hi');
    });
  });

  group('when a send goes wrong', () {
    test('a plain failure can be sent again, by the user only', () async {
      repo = FakeAgentRepository(premium: false)
        ..onSend = (_) => const Err(ServerFailure('Agent error: boom'));
      final vm = await chat();
      await vm.send('Hi');
      final failed = vm.messages.single;
      expect(failed.delivery, Delivery.failed);
      expect(failed.failure, 'Agent error: boom');
      expect(repo.calls.where((c) => c.startsWith('send')), hasLength(1));

      expect(vm.takeForResend(failed.id), 'Hi');
      expect(vm.messages, isEmpty);
    });

    test('lost connection, saved thread, answer arrived anyway: show it', () async {
      repo = FakeAgentRepository(threads: [thread(1, 'One')]);
      repo.onSend = (message) {
        repo.history[1]!.add(said(ChatRole.assistant, 'Late reply'));
        return const Err(UnknownOutcomeFailure());
      };
      final vm = await chat();
      await vm.send('Hi');
      expect(shown(vm), [
        (ChatRole.user, 'Hi', Delivery.delivered),
        (ChatRole.assistant, 'Late reply', Delivery.delivered),
      ]);
    });

    test('lost connection, received, no answer yet: wait, never resend', () async {
      repo = FakeAgentRepository(threads: [thread(1, 'One')])..onSend = lostConnection;
      final vm = await chat();
      await vm.send('Suggest trades');
      final message = vm.messages.single;
      expect(message.delivery, Delivery.unknown);
      expect(vm.takeForResend(message.id), isNull);

      // The answer is written later; "Check again" picks it up.
      repo.history[1]!.add(said(ChatRole.assistant, 'Here are two ideas'));
      await vm.loadHistory(1);
      expect(shown(vm).last, (ChatRole.assistant, 'Here are two ideas', Delivery.delivered));
      expect(repo.calls.where((c) => c.startsWith('send')), hasLength(1));
    });

    test('lost connection, never received: safe to send again', () async {
      repo = FakeAgentRepository(threads: [thread(1, 'One')])
        ..onSend = lostConnection
        ..receives = false;
      final vm = await chat();
      await vm.send('Hi');
      expect(vm.messages.single.delivery, Delivery.failed);
      expect(vm.takeForResend(vm.messages.single.id), 'Hi');
    });

    test('a gateway error on a saved thread is checked, not assumed', () async {
      // Render's proxy answers 502 while the agent may still be working.
      repo = FakeAgentRepository(threads: [thread(1, 'One')])
        ..onSend = (_) => const Err(BrokerFailure('busy', statusCode: 502));
      final vm = await chat();
      await vm.send('Received');
      expect(vm.messages.single.delivery, Delivery.unknown);

      repo.receives = false;
      await vm.loadHistory(1);
      await vm.send('Not received');
      final last = vm.messages.last;
      expect(last.delivery, Delivery.failed);
      expect(last.failure, 'busy');
    });

    test('lost connection, unsaved: a question may be resent, an approval may not', () async {
      repo = FakeAgentRepository(premium: false)..onSend = lostConnection;
      final vm = await chat(type: AgentType.trading);
      await vm.send('APPROVE a1b2c3d4');
      await vm.send('What is my margin?');
      final [approval, question] = vm.messages;
      expect(approval.delivery, Delivery.unknown);
      expect(question.delivery, Delivery.unknown);
      expect(vm.takeForResend(approval.id), isNull);
      expect(vm.takeForResend(question.id), 'What is my margin?');
    });

    test('one message at a time', () async {
      repo = FakeAgentRepository(premium: false)..gate = Completer();
      final vm = await chat();
      final first = vm.send('One');
      await settle();
      await vm.send('Two');
      repo.gate!.complete();
      await first;
      expect(repo.calls.where((c) => c.startsWith('send')), ['send:-:One']);
    });
  });

  test('an approval reply carries what the server did', () async {
    repo = FakeAgentRepository(premium: false)
      ..onSend = (_) => const Success(
        ChatReply(reply: 'Order placed.', approvalResult: 'Proposal a1b2c3d4 APPROVED'),
      );
    final vm = await chat(type: AgentType.trading);
    await vm.send('APPROVE a1b2c3d4');
    expect(vm.messages.last.approvalResult, 'Proposal a1b2c3d4 APPROVED');
  });

  group('drafts', () {
    test('kept per user and agent, surviving a restart', () async {
      repo = FakeAgentRepository(premium: false);
      final vm = await chat();
      vm.setDraft('Half a thought');
      await Future<void>.delayed(const Duration(milliseconds: 450));
      vm.dispose();

      final again = await chat();
      expect(again.draft, 'Half a thought');
      final trading = await chat(type: AgentType.trading);
      expect(trading.draft, isEmpty);

      await prefs.clearUser(hashUserId('A123'));
      expect((await chat()).draft, isEmpty);
    });

    test('a prefill opens a blank conversation with the text ready', () async {
      repo = FakeAgentRepository(threads: [thread(1, 'One')])
        ..history[1] = [said(ChatRole.user, 'Old')];
      final vm = await chat();
      final version = vm.draftVersion;
      await vm.prefill('Tell me about TCS');
      expect(vm.activeThreadId, isNull);
      expect(vm.messages, isEmpty);
      expect(vm.draft, 'Tell me about TCS');
      expect(vm.draftVersion, version + 1);
      expect(repo.calls.where((c) => c.startsWith('send')), isEmpty);
    });
  });
}
