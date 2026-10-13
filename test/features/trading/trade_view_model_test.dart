import 'dart:async';

import 'package:agentfolio/core/error/failure.dart';
import 'package:agentfolio/core/error/result.dart';
import 'package:agentfolio/core/telemetry/telemetry.dart';
import 'package:agentfolio/features/trading/domain/entities/trading.dart';
import 'package:agentfolio/features/trading/domain/trading_logic.dart';
import 'package:agentfolio/features/trading/presentation/view_models/risk_profile_view_model.dart';
import 'package:agentfolio/features/trading/presentation/view_models/trade_view_model.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/fake_trading.dart';
import '../../helpers/recording_sink.dart';

void main() {
  late Telemetry telemetry;
  late FakeTradingRepository repo;

  setUp(() async {
    (telemetry, _) = await recordingTelemetry();
    repo = FakeTradingRepository(proposals: [proposal('p1'), proposal('p2')]);
  });

  TradeViewModel vm({Duration poll = const Duration(milliseconds: 20)}) => TradeViewModel(
    trading: repo,
    telemetry: telemetry,
    pollEvery: poll,
    logsSettle: const Duration(milliseconds: 20),
  );

  group('approve', () {
    test('placed: the broker accepted', () async {
      final v = vm();
      final outcome = await v.approve('p1');
      expect((outcome! as OrderPlaced).orderId, 'ORD1');
      expect(v.outcomeFor('p1'), isA<OrderPlaced>());
      expect(repo.calls.where((c) => c.startsWith('approve')), ['approve:p1']);
    });

    test('blocked: a 200 with ok false is not a success', () async {
      repo.onApprove = (_) =>
          const Success(ExecutionResult(ok: false, error: 'Compliance check failed: max 10%'));
      final outcome = await vm().approve('p1');
      expect((outcome! as OrderNotPlaced).reason, contains('Compliance'));
    });

    test('answer lost, but it went through: read back as placed, never re-sent', () async {
      repo.onApprove = (id) {
        repo.settle(id, ProposalStatus.executed, orderId: 'ORD7');
        return const Err(UnknownOutcomeFailure());
      };
      final outcome = await vm().approve('p1');
      expect((outcome! as OrderPlaced).orderId, 'ORD7');
      expect(repo.calls.where((c) => c.startsWith('approve')), hasLength(1));
    });

    test('answer lost while the broker is still working: in progress', () async {
      repo.onApprove = (id) {
        repo.settle(id, ProposalStatus.approved);
        return const Err(BrokerFailure('busy', statusCode: 502));
      };
      expect(await vm().approve('p1'), isA<OrderInProgress>());
    });

    test('never reached the server: still pending, safe to try again', () async {
      repo.onApprove = (_) => const Err(NetworkFailure());
      expect(await vm().approve('p1'), isA<ApprovalNotReceived>());
    });

    test('lost, and the server no longer knows it: unconfirmed', () async {
      repo.onApprove = (id) {
        repo.list = [];
        return const Err(UnknownOutcomeFailure());
      };
      expect(await vm().approve('p1'), isA<OutcomeUnconfirmed>());
    });

    test('already decided elsewhere: the 400 is settled from the record', () async {
      repo.onApprove = (id) {
        repo.settle(id, ProposalStatus.rejected);
        return const Err(ValidationFailure('Proposal p1 is rejected, cannot approve'));
      };
      expect(await vm().approve('p1'), isA<OrderNotPlaced>());
    });

    test('a second tap while the first is in flight does nothing', () async {
      repo.approveGate = Completer();
      final v = vm();
      final first = v.approve('p1');
      await Future<void>.delayed(Duration.zero);
      expect(v.isApproving('p1'), isTrue);
      expect(await v.approve('p1'), isNull);
      expect((await v.reject('p1')).failureOrNull, isA<ValidationFailure>());
      repo.approveGate!.complete();
      await first;
      expect(repo.calls.where((c) => c.startsWith('approve')), hasLength(1));
    });
  });

  test('reject settles the proposal and refreshes the list', () async {
    final v = vm();
    await v.load();
    await v.reject('p2');
    expect(v.proposals.data!.firstWhere((p) => p.id == 'p2').status, ProposalStatus.rejected);
    expect(v.pendingCount, 1);
  });

  test('polls only while on screen and in the foreground', () async {
    final v = vm();
    await v.load();
    int polls() => repo.calls.where((c) => c == 'proposals').length;
    final start = polls();

    await Future<void>.delayed(const Duration(milliseconds: 70));
    expect(polls(), start, reason: 'not visible yet');

    v.setVisible(visible: true);
    await Future<void>.delayed(const Duration(milliseconds: 70));
    final visible = polls();
    expect(visible, greaterThan(start + 1));

    v.setForeground(foreground: false);
    await Future<void>.delayed(const Duration(milliseconds: 70));
    expect(polls(), visible, reason: 'backgrounded');
    expect(v.polling, isFalse);
    v.dispose();
  });

  test('a brief sent now is looked for in the log once it has had time', () async {
    final v = vm();
    await v.load();
    final before = repo.calls.where((c) => c == 'logs').length;
    await v.sendBriefingNow();
    await Future<void>.delayed(const Duration(milliseconds: 50));
    expect(repo.calls.where((c) => c == 'logs').length, before + 1);
  });

  test('the schedule is saved as IST HH:MM', () async {
    final v = vm();
    await v.saveSchedule(hour: 8, minute: 5, enabled: true);
    expect(repo.calls, contains('saveSchedule:08:05:true'));
  });

  group('risk profile form', () {
    test('a first profile starts from suggestions and is checked before saving', () async {
      final form = RiskProfileViewModel(trading: repo, telemetry: telemetry);
      expect(form.isNew, isTrue);
      expect(form.problems, isEmpty);
      form
        ..update((f) => f.age = '')
        ..update((f) => f.maxOrderValue = '500');
      expect(form.problems, isEmpty, reason: 'not shown until a save is tried');
      expect(await form.save(), isNull);
      expect(form.problems, {ProfileField.age, ProfileField.maxOrderValue});
      expect(repo.calls, isNot(contains('saveProfile')));

      form
        ..update((f) => f.age = '35')
        ..update((f) => f.maxOrderValue = '1,00,000');
      final saved = await form.save();
      expect(saved?.age, 35);
      expect(saved?.maxOrderValue, 100000);
    });

    test('editing knows whether anything changed', () {
      final form = RiskProfileViewModel(
        trading: repo,
        telemetry: telemetry,
        initial: RiskProfile.starter,
      );
      expect(form.dirty, isFalse);
      form.toggleProduct(ProductType.intraday);
      expect(form.dirty, isTrue);
      form.toggleProduct(ProductType.intraday);
      expect(form.dirty, isFalse);
    });

    test("the server's refusal is shown, not swallowed", () async {
      repo.saveFailure = const Err(ValidationFailure('age must be between 18 and 120'));
      final form = RiskProfileViewModel(trading: repo, telemetry: telemetry);
      await form.save();
      expect(form.saveFailure?.message, 'age must be between 18 and 120');
    });
  });
}
