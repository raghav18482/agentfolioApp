import 'package:agentfolio/core/presentation/base_view_model.dart';
import 'package:agentfolio/core/presentation/loadable.dart';
import 'package:agentfolio/features/research/domain/entities/glossary.dart';
import 'package:agentfolio/features/research/domain/repositories/research_repository.dart';

/// The metrics guide: the same glossary the scorer grades against, so every
/// threshold shown is the one actually used.
class LearnViewModel extends BaseViewModel {
  LearnViewModel({required this._research, required super.telemetry});

  final ResearchRepository _research;

  late final glossary = Loadable<Glossary>(
    fetch: ({required force}) => _research.glossary(),
    peek: _research.cachedGlossary,
    onChanged: notifyListeners,
  );

  Future<void> load() => glossary.load();
}
