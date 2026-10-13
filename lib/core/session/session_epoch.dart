/// A counter that moves every time "who is signed in, to which account"
/// changes: logout, login, account switch.
///
/// Work captures the epoch when it starts and checks it before publishing a
/// result. A slow response for the previous user or account is then dropped
/// instead of flashing their portfolio on screen.
class SessionEpoch {
  int _value = 0;

  int get current => _value;

  void advance() => _value++;

  bool isCurrent(int epoch) => epoch == _value;
}
