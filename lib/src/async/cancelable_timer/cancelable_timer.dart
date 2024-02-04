// SPDX-FileCopyrightText: © 2023 - 2024 Anthony Champagne <dev@anthonychampagne.fr>
//
// SPDX-License-Identifier: BSD-3-Clause

import 'dart:async';

import 'package:async/async.dart';

part 'cancelable_timer.periodic.dart';

abstract class CancelableTimer {
  factory CancelableTimer.periodic(
    Duration duration,
    CancelableOperation Function(CancelableTimer timer) callback, {
    bool wait,
  }) = CancelableTimerPeriodic;

  int get tick;

  bool get isActive;

  void cancel();
}
