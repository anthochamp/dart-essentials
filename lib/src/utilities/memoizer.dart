// Copyright 2023, Anthony Champagne. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

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
