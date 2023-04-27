// Copyright 2023, Anthony Champagne. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

extension AnsiStringExtension on String {
  /// Remove ANSI characters from a string
  String removeAnsiChars() =>
      replaceAll(RegExp(r'(\x9B|\x1B\[)[0-?]*[ -\/]*[@-~]'), '');
}
