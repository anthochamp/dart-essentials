extension PatternTrimStringExtension on String {
  String patternTrim(Pattern pattern) =>
      patternTrimLeft(pattern).patternTrimRight(pattern);

  String patternTrimLeft(Pattern pattern) =>
      replaceFirst(RegExp('^$pattern'), '');

  String patternTrimRight(Pattern pattern) =>
      replaceFirst(RegExp('$pattern\$'), '');
}
