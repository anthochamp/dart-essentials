// SPDX-FileCopyrightText: © 2023 - 2026 Anthony Champagne <dev@anthonychampagne.fr>
//
// SPDX-License-Identifier: BSD-3-Clause

import 'dart:math';

/// A class that keep an offset attached to a string giving
/// a C-string-pointer like object.
class StringPointer {
  final String string;

  StringPointer(this.string);

  StringPointer._withOffset(this.string, this._offset);

  String? _value;
  int _offset = 0;

  int get offset => _offset;
  set offset(int offset) {
    if (_offset != offset) {
      _offset = offset;
      _value = null;
    }
  }

  int get length => string.length;

  bool get overflow => offset >= length;

  String get value {
    // ignore: avoid-substring
    _value ??= string.substring(max(0, min(offset, length)));

    return _value!;
  }

  /// Returns a new [StringPointer] pointing [count] positions ahead.
  StringPointer operator +(int count) =>
      StringPointer._withOffset(string, _offset + count);

  /// Returns a new [StringPointer] pointing [count] positions behind.
  StringPointer operator -(int count) =>
      StringPointer._withOffset(string, _offset - count);
}
