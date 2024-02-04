// SPDX-FileCopyrightText: © 2023 - 2024 Anthony Champagne <dev@anthonychampagne.fr>
//
// SPDX-License-Identifier: BSD-3-Clause

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
