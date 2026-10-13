import 'package:agentfolio/core/error/failure.dart';
import 'package:agentfolio/core/error/result.dart';
import 'package:agentfolio/core/network/failure_mapper.dart';
import 'package:agentfolio/core/network/json.dart';
import 'package:dio/dio.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:logging/logging.dart';

final _log = Logger('Api');

/// Runs a data-source call and returns its value or the [Failure] it hit.
///
/// The repository boundary: nothing above it sees a [DioException]. A
/// response we could not parse means the API contract moved, so it is logged
/// as an error, which reaches Crashlytics as a non-fatal with breadcrumbs.
Future<Result<T>> guardApi<T>(Future<T> Function() call) async {
  try {
    return Success(await call());
  } on DioException catch (e) {
    return Err(mapDioException(e));
  } on UnavailableDataException catch (e) {
    return Err(UnavailableFailure(e.message));
  } on CheckedFromJsonException catch (e, s) {
    _log.severe('Response did not match the expected shape', e, s);
    return const Err(ParseFailure());
  } on FormatException catch (e, s) {
    _log.severe('Malformed response', e, s);
    return const Err(ParseFailure());
  } on Object catch (e, s) {
    // A cast in a decoder throws TypeError on an unexpected shape. That is a
    // contract change to report, not a crash. Anything else is a real bug.
    if (e is! TypeError) rethrow;
    _log.severe('Response had an unexpected type', e, s);
    return const Err(ParseFailure());
  }
}
