// Copyright 2023, Anthony Champagne. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

extension PatternTrimStringExtension on String {
  /// Like `String.trim` but let you specify the pattern to trim.
  String patternTrim(Pattern pattern) =>
      patternTrimLeft(pattern).patternTrimRight(pattern);

  /// Like `String.trimLeft` but let you specify the pattern to trim.
  String patternTrimLeft(Pattern pattern) =>
      replaceFirst(RegExp('^$pattern'), '');

  /// Like `String.trimRight` but let you specify the pattern to trim.
  String patternTrimRight(Pattern pattern) =>
      replaceFirst(RegExp('$pattern\$'), '');
}
