// SPDX-FileCopyrightText: © 2023 - 2026 Anthony Champagne <dev@anthonychampagne.fr>
//
// SPDX-License-Identifier: BSD-3-Clause

/// Synchronous version of `AsyncMemoizer`
class Memoizer<T> {
  late T _value;
  bool _hasRun = false;

  /// The result computed by [runOnce].
  ///
  /// Accessing [value] before calling [runOnce] throws a [StateError].
  T get value {
    if (!_hasRun) {
      throw StateError('Memoizer.value accessed before runOnce was called');
    }
    return _value;
  }

  bool get hasRun => _hasRun;

  T runOnce(T Function() computation) {
    if (!_hasRun) {
      _value = computation();
      _hasRun = true;
    }

    return _value;
  }
}
