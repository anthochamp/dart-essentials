// SPDX-FileCopyrightText: © 2023 - 2026 Anthony Champagne <dev@anthonychampagne.fr>
//
// SPDX-License-Identifier: BSD-3-Clause

extension PatternExtensions on Pattern {
  /// Returns the raw pattern source string regardless of whether `this` is a
  /// plain [String] or a [RegExp].
  String get _patternSource =>
      this is RegExp ? (this as RegExp).pattern : toString();

  /// Match entire pattern against the provided `string`, optionally with `unicode` matching
  bool entireMatch(String string, {bool unicode = false}) =>
      RegExp(
        '^$_patternSource\$',
        unicode: unicode,
      ).firstMatch(string) !=
      null;

  /// Match entire pattern against the provided `string` in a case-insensitive way, optionally with `unicode` matching
  bool entireMatchI(String string, {bool unicode = false}) =>
      RegExp(
        '^$_patternSource\$',
        unicode: unicode,
        caseSensitive: false,
      ).firstMatch(string) !=
      null;

  /// Enclose the pattern with a group.
  ///
  /// When [name] is provided, produces a named capture group `(?<name>...)`.
  /// Without a name, produces a non-capturing group `(?:...)`.
  String captureGroup([String? name]) =>
      name == null ? '(?:$_patternSource)' : '(?<$name>$_patternSource)';

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
    final inPattern = prePattern._patternSource +
        captureGroup(inCaptureName) +
        postPattern._patternSource;

    return inPattern.captureGroup(outCaptureName);
  }
}
