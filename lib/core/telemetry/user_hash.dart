import 'dart:convert';

import 'package:crypto/crypto.dart';

/// A stable, non-reversible id for analytics and crash reports.
///
/// The same user always maps to the same hash, so their sessions group
/// together, but the hash does not reveal their broker client code.
String hashUserId(String id) =>
    sha256.convert(utf8.encode('agentfolio-telemetry:$id')).toString().substring(0, 32);
