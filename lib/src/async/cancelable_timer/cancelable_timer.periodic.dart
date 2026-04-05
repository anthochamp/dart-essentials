// SPDX-FileCopyrightText: © 2023 - 2026 Anthony Champagne <dev@anthonychampagne.fr>
//
// SPDX-License-Identifier: BSD-3-Clause

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
      // Schedule the next tick immediately (without waiting for the operation
      // to complete), but still clear _operation once this one finishes so
      // that future ticks can fire the callback again.
      unawaited(operation.value.whenComplete(() => _operation = null));
      _next();
    }
  }

  void _next() {
    if (!_cancelled) {
      Timer(duration, _call);
    }
  }
}
