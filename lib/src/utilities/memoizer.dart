class Memoizer<T> {
  late T _value;
  bool _hasRun = false;

  T get value => _value;

  bool get hasRun => _hasRun;

  T runOnce(T Function() computation) {
    if (!_hasRun) {
      _value = computation();
      _hasRun = true;
    }

    return _value;
  }
}
