import 'package:agentfolio/core/error/result.dart';
import 'package:agentfolio/features/research/data/models/research_dtos.dart';
import 'package:agentfolio/features/research/domain/entities/fundamentals.dart';
import 'package:agentfolio/features/research/domain/entities/glossary.dart';
import 'package:agentfolio/features/research/domain/entities/prediction.dart';
import 'package:agentfolio/features/research/domain/entities/technicals.dart';
import 'package:agentfolio/features/research/domain/repositories/research_repository.dart';

import '../features/research/research_fixtures.dart';

/// Answers from the server-shaped fixtures and counts every call, so tests
/// can assert what loaded when.
class FakeResearchRepository implements ResearchRepository {
  Result<Technicals> technicalsResult = Success(TechnicalsDto.fromJson(technicalJson()).toEntity());
  Result<Fundamentals> fundamentalsResult = Success(
    FundamentalsDto.fromJson(fundamentalJson()).toEntity(),
  );
  Result<Prediction> predictionResult = Success(
    PredictionDto.fromJson(predictionJson()).toEntity(),
  );
  Result<Glossary> glossaryResult = Success(GlossaryDto.fromJson(glossaryJson()).toEntity());
  AiSummary Function() summaryValue = () =>
      AiSummary(markdown: 'A **solid** business.', cached: false, receivedAt: DateTime.now());

  final calls = <String>[];

  @override
  Future<Result<Technicals>> technicals(String symbol, {bool force = false}) async {
    calls.add('technicals');
    return technicalsResult;
  }

  @override
  Future<Result<Fundamentals>> fundamentals(String symbol, {bool force = false}) async {
    calls.add('fundamentals');
    return fundamentalsResult;
  }

  @override
  Future<Result<Prediction>> prediction(String symbol, {bool force = false}) async {
    calls.add('prediction');
    return predictionResult;
  }

  @override
  Future<Result<AiSummary>> summary(String symbol, {bool regenerate = false}) async {
    calls.add(regenerate ? 'summary:regenerate' : 'summary');
    return Success(summaryValue());
  }

  @override
  Future<Result<Glossary>> glossary() async {
    calls.add('glossary');
    return glossaryResult;
  }

  @override
  Glossary? cachedGlossary() => null;
}
