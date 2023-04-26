import 'package:dart_essentials/src/extensions/runes/truncate_extension.dart';

class InspectOptions {
  final int maxListSetLength;
  final int maxStringLength;
  final int maxMapKeysCount;
  final int depth;
  final String indent;
  final String stringQuotes;
  final bool autoBreak;
  final bool preferCompact;
  final String mapKeyValueSep;

  InspectOptions({
    this.maxListSetLength = 50,
    this.maxStringLength = 10000,
    this.maxMapKeysCount = 100,
    this.depth = 2,
    this.indent = '  ',
    this.stringQuotes = '',
    this.autoBreak = false,
    this.preferCompact = true,
    this.mapKeyValueSep = '=',
  });
}

String _prependLines(String value, String prepend) {
  return '$prepend${value.split('\n').join('\n$prepend')}';
}

String _inspectValue(dynamic value, InspectOptions options, int deepLevel) {
  String result;

  if (value is String) {
    result =
        '${options.stringQuotes}${value.truncate(maxLength: options.maxStringLength)}${options.stringQuotes}';
  } else if (value is Iterable) {
    final enclose = value is List ? '[]' : '()';

    final list = value
        .take(options.maxListSetLength)
        .map((e) => _inspectValue(e, options, deepLevel + 1))
        .toList();

    if (value.length > options.maxListSetLength) {
      // ignore: avoid-non-ascii-symbols
      list.add('…');
    }

    final hasCR = list.any((e) => e.contains('\n'));

    if (options.preferCompact && !hasCR) {
      result = enclose[0] + list.join(', ') + enclose[1];
    } else {
      result = _prependLines('\n${list.join('\n')}', options.indent);
    }
  } else if (value is Map) {
    final list = value.entries
        .take(options.maxMapKeysCount)
        .map(
          (e) =>
              '${e.key}${options.mapKeyValueSep}${_inspectValue(e.value, options, deepLevel + 1)}',
        )
        .toList();

    if (value.length > options.maxMapKeysCount) {
      // ignore: avoid-non-ascii-symbols
      list.add('…');
    }

    final hasCR = list.any((e) => e.contains('\n'));

    if (options.preferCompact && !hasCR) {
      result = '{${list.join(', ')}}';
    } else {
      result = _prependLines('\n${list.join('\n')}', options.indent);
    }
  } else {
    result = value.toString();
  }

  return result;
}

String inspectValue(dynamic value, [InspectOptions? options]) =>
    _inspectValue(value, options ?? InspectOptions(), 0);

extension InspectStringExtension on String {
  String inspect([InspectOptions? options]) => inspectValue(this, options);
}

extension InspectListExtension on List {
  String inspect([InspectOptions? options]) => inspectValue(this, options);
}

extension InspectSetExtension on Set {
  String inspect([InspectOptions? options]) => inspectValue(this, options);
}

extension InspectMapExtension on Map {
  String inspect([InspectOptions? options]) => inspectValue(this, options);
}
