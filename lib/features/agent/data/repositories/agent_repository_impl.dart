import 'package:agentfolio/core/cache/request_cache.dart';
import 'package:agentfolio/core/error/result.dart';
import 'package:agentfolio/core/network/guard_api.dart';
import 'package:agentfolio/features/agent/data/datasources/agent_remote_data_source.dart';
import 'package:agentfolio/features/agent/domain/entities/agent.dart';
import 'package:agentfolio/features/agent/domain/repositories/agent_repository.dart';

class AgentRepositoryImpl implements AgentRepository {
  AgentRepositoryImpl(this._remote, this._cache);

  final AgentRemoteDataSource _remote;
  final RequestCache _cache;

  /// Every change made from this device updates the list itself, so this
  /// only bounds how long a change from the web takes to show.
  static const _threadsTtl = Duration(minutes: 2);

  static String _threadsKey(AgentType type) => 'agent/threads/${type.wire}';

  @override
  Future<Result<ThreadList>> threads(AgentType type, {bool force = false}) => guardApi(
    () => _cache.fetch(
      _threadsKey(type),
      ttl: _threadsTtl,
      force: force,
      load: () async => (await _remote.threads(type)).toEntity(),
    ),
  );

  @override
  ThreadList? cachedThreads(AgentType type) => _cache.peek(_threadsKey(type));

  @override
  Future<Result<List<ChatMessage>>> messages(int threadId) => guardApi(() async {
    final dtos = await _remote.messages(threadId);
    return [for (final (i, m) in dtos.indexed) m.toEntity('h$threadId-$i')];
  });

  @override
  Future<Result<ChatThread>> createThread(AgentType type) async {
    final result = await guardApi(() async => (await _remote.createThread(type)).toEntity());
    if (result case Success(:final value)) _update(type, (list) => [value, ...list]);
    return result;
  }

  @override
  Future<Result<ChatThread>> rename(int threadId, String title) async {
    final result = await guardApi(() async => (await _remote.rename(threadId, title)).toEntity());
    if (result case Success(:final value)) {
      _update(
        value.agentType,
        (list) => [
          for (final t in list)
            if (t.id == threadId) value else t,
        ],
      );
    }
    return result;
  }

  @override
  Future<Result<void>> delete(int threadId) async {
    final result = await guardApi(() => _remote.delete(threadId));
    if (result is Success) {
      for (final type in AgentType.values) {
        _update(
          type,
          (list) => [
            for (final t in list)
              if (t.id != threadId) t,
          ],
        );
      }
    }
    return result;
  }

  @override
  Future<Result<ChatReply>> send(String message, AgentType type, {int? threadId}) async {
    final result = await guardApi(
      () async => (await _remote.chat(message, type, threadId)).toEntity(),
    );
    // A reply renames a new thread and moves it to the top: fetch afresh.
    if (threadId != null) _cache.invalidate(_threadsKey(type));
    // A trading reply can create or settle a proposal.
    if (type == AgentType.trading) _cache.invalidate('trading/');
    return result;
  }

  @override
  Future<Result<void>> resetUnsaved(AgentType type) => guardApi(() => _remote.resetUnsaved(type));

  /// Applies a change made here to the cached list, so it shows without a
  /// round trip.
  void _update(AgentType type, List<ChatThread> Function(List<ChatThread>) change) {
    final cached = cachedThreads(type);
    if (cached == null) return;
    _cache.put(_threadsKey(type), cached.copyWith(threads: change(cached.threads)));
  }
}
