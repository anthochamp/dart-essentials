// SPDX-FileCopyrightText: © 2023 - 2024 Anthony Champagne <dev@anthonychampagne.fr>
//
// SPDX-License-Identifier: BSD-3-Clause

import 'dart:math';

/// A class that keep an offset attached to a string giving
/// a C-string-pointer like object.
class StringPointer {
  final String string;

  StringPointer(this.string);

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

  StringPointer operator +(int count) {
    offset += count;

    return this;
  }

  StringPointer operator -(int count) {
    offset -= count;

    return this;
  }
}
