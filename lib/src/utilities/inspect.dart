// SPDX-FileCopyrightText: © 2023 - 2024 Anthony Champagne <dev@anthonychampagne.fr>
//
// SPDX-License-Identifier: BSD-3-Clause

import '../extensions/runes/truncate_extension.dart';
import '../extensions/string/lines_string_extension.dart';

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

  const InspectOptions({
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

class Inspect {
  final InspectOptions options;

  Inspect([InspectOptions? options])
      : options = options ?? const InspectOptions();

  /// Node.js's `inspect`-like method
  String inspect(dynamic value) => _inspectValue(value);

  String _inspectValue(dynamic value, [int deepLevel = 0]) {
    String result;

    if (value is String) {
      result =
          '${options.stringQuotes}${value.truncate(maxLength: options.maxStringLength)}${options.stringQuotes}';
    } else if (value is Iterable) {
      final enclose = value is List ? '[]' : '()';

      final list = value
          .take(options.maxListSetLength)
          .map((e) => _inspectValue(e, deepLevel + 1))
          .toList();

      if (value.length > options.maxListSetLength) {
        // ignore: avoid-non-ascii-symbols
        list.add('…');
      }

      final hasCR = list.any((e) => e.contains('\n'));

      if (options.preferCompact && !hasCR) {
        result = enclose[0] + list.join(', ') + enclose[1];
      } else {
        result = '\n${list.join('\n')}'.prependLines(options.indent);
      }
    } else if (value is Map) {
      final list = value.entries
          .take(options.maxMapKeysCount)
          .map(
            (e) =>
                '${e.key}${options.mapKeyValueSep}${_inspectValue(e.value, deepLevel + 1)}',
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
        result = '\n${list.join('\n')}'.prependLines(options.indent);
      }
    } else {
      result = value.toString();
    }

    return result;
  }
}
