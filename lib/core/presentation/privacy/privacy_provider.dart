import 'dart:async';

import 'package:agentfolio/core/storage/prefs.dart';
import 'package:flutter/foundation.dart';

/// "Hide balances": masks every amount in the app (`MoneyText` shows ₹••••)
/// for looking at the app in public. Remembered across launches.
class PrivacyProvider extends ChangeNotifier {
  PrivacyProvider(this._prefs) : _hidden = _prefs.hideBalances;

  final Prefs _prefs;
  bool _hidden;

  bool get hideBalances => _hidden;

  void toggle() {
    _hidden = !_hidden;
    unawaited(_prefs.setHideBalances(hide: _hidden));
    notifyListeners();
  }
}
