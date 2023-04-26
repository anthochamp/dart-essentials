part of 'cancelable_timer.dart';

class CancelableTimerPeriodic implements CancelableTimer {
  final Duration duration;
  final CancelableOperation Function(CancelableTimer timer) callback;
  final bool wait;

  CancelableTimerPeriodic(
    this.duration,
    this.callback, {
    this.wait = true,
  }) {
    _call();
  }

  int _tick = 0;
  bool _cancelled = false;
  CancelableOperation? _operation;

  @override
  int get tick => _tick;

  @override
  bool get isActive => !_cancelled;

  @override
  void cancel() {
    _cancelled = true;
    _operation?.cancel();
  }

  void _call() {
    _tick++;

    if (_cancelled || _operation != null) {
      return;
    }

    final operation = callback(this);

    _operation = operation;

    if (wait) {
      unawaited(operation.value.whenComplete(() {
        _operation = null;
        _next();
      }));
    } else {
      _next();
    }
  }

  void _next() {
    if (!_cancelled) {
      Timer(duration, _call);
    }
  }
}
