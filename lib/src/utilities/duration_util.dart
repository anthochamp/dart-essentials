// Copyright 2023, Anthony Champagne. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

class DurationUtil {
  static Duration? min(
    Duration? a,
    Duration? b, {
    bool ignoreNull = true,
  }) {
    if (a == null) {
      return ignoreNull ? b : null;
    }

    if (b == null) {
      return ignoreNull ? a : null;
    }

    return a < b ? a : b;
  }

  static Duration? max(
    Duration? a,
    Duration? b, {
    bool ignoreNull = true,
  }) {
    if (a == null) {
      return ignoreNull ? b : null;
    }

    if (b == null) {
      return ignoreNull ? a : null;
    }

    return a < b ? b : a;
  }

  static Duration? add(
    Duration? a,
    Duration? b, {
    bool nullIsZero = false,
  }) {
    if (a == null) {
      return nullIsZero ? b : null;
    }

    if (b == null) {
      return nullIsZero ? a : null;
    }

    return a + b;
  }

  static Duration? substract(
    Duration? a,
    Duration? b, {
    bool nullIsZero = false,
  }) {
    if (a == null) {
      if (nullIsZero) {
        return b == null ? null : -b;
      } else {
        return null;
      }
    }

    if (b == null) {
      return nullIsZero ? a : null;
    }

    return a - b;
  }

  static bool? lt(Duration? a, Duration b) => a == null ? null : a < b;
  static bool? lte(Duration? a, Duration b) => a == null ? null : a <= b;
  static bool? gt(Duration? a, Duration b) => a == null ? null : a > b;
  static bool? gte(Duration? a, Duration b) => a == null ? null : a >= b;
  static bool? equal(Duration? a, Duration b) => a == null ? null : a == b;
}
