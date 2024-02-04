// SPDX-FileCopyrightText: © 2023 - 2024 Anthony Champagne <dev@anthonychampagne.fr>
//
// SPDX-License-Identifier: BSD-3-Clause

extension PatternExtensions on Pattern {
  /// Match entire pattern against the provided `string`, optionally with `unicode` matching
  bool entireMatch(String string, {bool unicode = false}) =>
      RegExp(
        '^$this\$',
        unicode: unicode,
      ).firstMatch(string) !=
      null;

  /// Match entire pattern against the provided `string` in a case-insensitive way, optionally with `unicode` matching
  bool entireMatchI(String string, {bool unicode = false}) =>
      RegExp(
        '^$this\$',
        unicode: unicode,
        caseSensitive: false,
      ).firstMatch(string) !=
      null;

  /// Enclose the pattern with a capture group, optionally named with `name`
  String namedCapture([String? name]) =>
      name == null ? '(?:$this)' : '(?<$name>$this)';

  /// Enclose the pattern with in-out capture groups, provided `pre`/`post` pattern strings.
  ///
  /// Given :
  /// - A pattern 'foo',
  /// - `prePattern` = `'"'`,
  /// - `postPattern` = `'"'`,
  /// - `inCaptureName` = `'in'`,
  /// - `outCaptureName` = `'out'`,
  ///
  /// The resulting pattern will be :
  /// `(?<out>"(?<in>foo)")`
  String inoutCapture({
    Pattern prePattern = '',
    Pattern postPattern = '',
    String? inCaptureName,
    String? outCaptureName,
  }) {
    final inPattern = prePattern.toString() +
        namedCapture(inCaptureName) +
        postPattern.toString();

    return inPattern.namedCapture(outCaptureName);
  }
}
