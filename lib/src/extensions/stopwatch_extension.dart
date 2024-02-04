// SPDX-FileCopyrightText: © 2023 - 2024 Anthony Champagne <dev@anthonychampagne.fr>
//
// SPDX-License-Identifier: BSD-3-Clause

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
