extension MatchWholePatternExtension on Pattern {
  bool entireMatch(String string, {bool unicode = false}) =>
      RegExp(
        '^$this\$',
        unicode: unicode,
      ).firstMatch(string) !=
      null;

  bool entireMatchI(String string, {bool unicode = false}) =>
      RegExp(
        '^$this\$',
        unicode: unicode,
        caseSensitive: false,
      ).firstMatch(string) !=
      null;

  String namedCapture([String? name]) =>
      name == null ? '(?:$this)' : '(?<$name>$this)';

  String inoutCapture({
    Pattern prePattern = '',
    Pattern postPattern = '',
    String? inPatternName,
    String? outPatternName,
  }) {
    final inPattern = prePattern.toString() +
        namedCapture(inPatternName) +
        postPattern.toString();

    return inPattern.namedCapture(outPatternName);
  }
}
