import 'package:agentfolio/core/broker/broker_descriptor.dart';
import 'package:agentfolio/core/broker/brokers/angel_one.dart';

/// The brokers this build supports.
///
/// To add one: write `brokers/<name>.dart` with its [BrokerDescriptor] and
/// list it here. The link-account form, copy and capability checks all read
/// from the descriptor.
class BrokerRegistry {
  BrokerRegistry([List<BrokerDescriptor>? brokers])
    : _brokers = {
        for (final b in brokers ?? [angelOne]) b.id: b,
      };

  final Map<BrokerId, BrokerDescriptor> _brokers;

  /// Today's backend is Angel One only and does not name the broker in its
  /// responses, so an unnamed account is assumed to be this one.
  static const defaultBrokerId = BrokerId('angel_one');

  List<BrokerDescriptor> get all => List.unmodifiable(_brokers.values);

  BrokerDescriptor? find(BrokerId id) => _brokers[id];

  /// The descriptor for [id], falling back to the default broker for an id
  /// this build does not know (a newer backend). The app keeps working with
  /// generic copy instead of crashing.
  BrokerDescriptor resolve(BrokerId? id) =>
      _brokers[id] ?? _brokers[defaultBrokerId] ?? _brokers.values.first;
}
