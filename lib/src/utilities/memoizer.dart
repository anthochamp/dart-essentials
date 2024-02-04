// SPDX-FileCopyrightText: © 2023 - 2024 Anthony Champagne <dev@anthonychampagne.fr>
//
// SPDX-License-Identifier: BSD-3-Clause

/// Synchronous version of `AsyncMemoizer`
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
