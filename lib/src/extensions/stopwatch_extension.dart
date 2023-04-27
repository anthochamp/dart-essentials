// Copyright 2023, Anthony Champagne. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:collection/collection.dart';

extension StopwatchExtension on Stopwatch {
  /// Calculate time left on a `timeout` Duration value, optionally with
  /// a `absoluteTimeout` value which do not depend on stopwatch elapsed time.
  ///
  /// Null values are ignored. If both timeout and absoluteTimeout are null, null is returned.
  Duration? timeLeft(Duration? timeout, [Duration? absoluteTimeout]) => minBy(
        [timeout == null ? null : timeout - elapsed, absoluteTimeout]
            .expand<Duration>((e) => e == null ? [] : [e]),
        (e) => e,
      );
}
