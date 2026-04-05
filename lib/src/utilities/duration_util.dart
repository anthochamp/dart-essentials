// SPDX-FileCopyrightText: © 2023 - 2026 Anthony Champagne <dev@anthonychampagne.fr>
//
// SPDX-License-Identifier: BSD-3-Clause

/// Returns the smaller of [a] and [b].
///
/// If [ignoreNull] is `true` (default), a `null` argument is treated as
/// "infinity" and the non-null value is returned. If both are `null`, returns
/// `null`. When [ignoreNull] is `false`, any `null` input returns `null`.
Duration? durationMin(
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

/// Returns the larger of [a] and [b].
///
/// Null-handling mirrors [durationMin].
Duration? durationMax(
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

/// Returns [a] + [b], or `null` if either operand is `null`.
///
/// When [nullIsZero] is `true`, a `null` operand is treated as
/// [Duration.zero]; the result is `null` only when both operands are `null`.
Duration? durationAdd(
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

/// Returns [a] − [b], or `null` if either operand is `null`.
///
/// When [nullIsZero] is `true`, a `null` operand is treated as
/// [Duration.zero]; the result is `null` only when both operands are `null`.
Duration? durationSubtract(
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

/// Returns `a < b`, or `null` when [a] is `null`.
bool? durationLt(Duration? a, Duration b) => a == null ? null : a < b;

/// Returns `a <= b`, or `null` when [a] is `null`.
bool? durationLte(Duration? a, Duration b) => a == null ? null : a <= b;

/// Returns `a > b`, or `null` when [a] is `null`.
bool? durationGt(Duration? a, Duration b) => a == null ? null : a > b;

/// Returns `a >= b`, or `null` when [a] is `null`.
bool? durationGte(Duration? a, Duration b) => a == null ? null : a >= b;

/// Returns `a == b`, or `null` when [a] is `null`.
bool? durationEqual(Duration? a, Duration b) => a == null ? null : a == b;

/// Null-safe Duration helpers exposed as static methods.
///
/// Deprecated — use the equivalent top-level functions instead:
/// [durationMin], [durationMax], [durationAdd], [durationSubtract],
/// [durationLt], [durationLte], [durationGt], [durationGte], [durationEqual].
@Deprecated(
    'Use top-level durationMin/Max/Add/Subtract/Lt/Lte/Gt/Gte/Equal functions')
class DurationUtil {
  @Deprecated('Use durationMin')
  static Duration? min(Duration? a, Duration? b, {bool ignoreNull = true}) =>
      durationMin(a, b, ignoreNull: ignoreNull);

  @Deprecated('Use durationMax')
  static Duration? max(Duration? a, Duration? b, {bool ignoreNull = true}) =>
      durationMax(a, b, ignoreNull: ignoreNull);

  @Deprecated('Use durationAdd')
  static Duration? add(Duration? a, Duration? b, {bool nullIsZero = false}) =>
      durationAdd(a, b, nullIsZero: nullIsZero);

  @Deprecated('Use durationSubtract')
  static Duration? substract(
    Duration? a,
    Duration? b, {
    bool nullIsZero = false,
  }) =>
      durationSubtract(a, b, nullIsZero: nullIsZero);

  @Deprecated('Use durationLt')
  static bool? lt(Duration? a, Duration b) => durationLt(a, b);

  @Deprecated('Use durationLte')
  static bool? lte(Duration? a, Duration b) => durationLte(a, b);

  @Deprecated('Use durationGt')
  static bool? gt(Duration? a, Duration b) => durationGt(a, b);

  @Deprecated('Use durationGte')
  static bool? gte(Duration? a, Duration b) => durationGte(a, b);

  @Deprecated('Use durationEqual')
  static bool? equal(Duration? a, Duration b) => durationEqual(a, b);
}
