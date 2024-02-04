// SPDX-FileCopyrightText: © 2023 - 2024 Anthony Champagne <dev@anthonychampagne.fr>
//
// SPDX-License-Identifier: BSD-3-Clause

// ignore_for_file: avoid-non-ascii-symbols, avoid-substring

import 'package:characters/characters.dart';

enum TruncatePosition {
  start,
  center,
  end,
}

extension TruncateStringExtension on String {
  /// Truncate string
  String truncate({
    required int maxLength,
    bool breakWord = true,
    TruncatePosition position = TruncatePosition.end,
    String truncateIndicator = '…',
    Pattern wordSeparator = r'\s',
    bool keepWordSeparator = false,
  }) {
    assert(!maxLength.isNegative);

    if (characters.length <= maxLength) {
      return this;
    }

    final wordSeparatorRegExp = RegExp(wordSeparator.toString(), unicode: true);

    switch (position) {
      case TruncatePosition.start:
        if (breakWord) {
          return truncateIndicator +
              characters.getRange(characters.length - maxLength).string;
        } else {
          final separators = wordSeparatorRegExp.allMatches(this);
          String lastEnd = '';
          for (final separator in separators.toList().reversed) {
            final end =
                substring(keepWordSeparator ? separator.start : separator.end);
            if (end.characters.length > maxLength) {
              break;
            }
            lastEnd = end;
          }

          return truncateIndicator + lastEnd;
        }

      case TruncatePosition.center:
        {
          if (breakWord) {
            final firstPart = characters.getRange(0, (maxLength / 2).ceil());

            return firstPart.string +
                truncateIndicator +
                characters
                    .getRange(
                      characters.length - (maxLength - firstPart.length),
                    )
                    .string;
          } else {
            final separators = wordSeparatorRegExp.allMatches(this).toList();
            String lastStart = '';
            String lastEnd = '';

            for (int separatorIndex = 0;
                separatorIndex < separators.length;
                separatorIndex++) {
              if (separatorIndex % 2 == 0) {
                final separator = separators[(separatorIndex / 2).floor()];
                final start = substring(
                  0,
                  keepWordSeparator ? separator.end : separator.start,
                );
                if (start.characters.length + lastEnd.characters.length >
                    maxLength) {
                  break;
                }
                lastStart = start;
              } else {
                final separator = separators[
                    separators.length - (separatorIndex / 2).floor() - 1];
                final end = substring(
                  keepWordSeparator ? separator.start : separator.end,
                );
                if (lastStart.characters.length + end.characters.length >
                    maxLength) {
                  break;
                }
                lastEnd = end;
              }
            }

            return lastStart + truncateIndicator + lastEnd;
          }
        }

      case TruncatePosition.end:
        if (breakWord) {
          return characters.getRange(0, maxLength).string + truncateIndicator;
        } else {
          final separators = wordSeparatorRegExp.allMatches(this);
          String lastStart = '';
          for (final separator in separators) {
            final start = substring(
              0,
              keepWordSeparator ? separator.end : separator.start,
            );
            if (start.characters.length > maxLength) {
              break;
            }
            lastStart = start;
          }

          return lastStart + truncateIndicator;
        }
    }
  }
}
