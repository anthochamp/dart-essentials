// Copyright 2023, Anthony Champagne. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

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
