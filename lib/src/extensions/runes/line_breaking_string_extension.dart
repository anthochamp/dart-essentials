// SPDX-FileCopyrightText: © 2023 - 2024 Anthony Champagne <dev@anthonychampagne.fr>
//
// SPDX-License-Identifier: BSD-3-Clause

import 'dart:collection';
import 'dart:math';

extension LineBreakingStringExtension on String {
  /// Break line at word separation using a minimum raggedness algorithm.
  ///
  /// Based on "Divide & Conquer" algorithm from https://xxyxyz.org/line-breaking/ with
  /// `wordSeparation` optional argument from https://cs.stackexchange.com/questions/123423/line-breaking-algorithm-minimum-raggedness-where-spaces-can-have-width-differe
  ///
  /// See: https://en.wikipedia.org/wiki/Line_wrap_and_word_wrap#Minimum_raggedness
  Iterable<String> breakLine(int maxLineLength, [String wordSeparation = ' ']) {
    if (length <= maxLineLength.toInt()) {
      return [this];
    }

    final words = split(wordSeparation);
    final wordsCount = words.length;
    final wordsOffsets = <BigInt>[BigInt.zero];
    for (final word in words) {
      wordsOffsets.add(wordsOffsets.last + BigInt.from(word.length));
    }

    final minima = [
      BigInt.zero,
      ...List.filled(wordsCount, BigInt.from(10).pow(20)),
    ];
    final breaks = List.filled(wordsCount + 1, BigInt.zero);

    BigInt cost(BigInt i, BigInt j) {
      final iAsInt = i.toInt();
      final lineLength = wordsOffsets[j.toInt()] -
          wordsOffsets[iAsInt] +
          (j - i - BigInt.one) * BigInt.from(wordSeparation.length);
      if (lineLength > BigInt.from(maxLineLength)) {
        return BigInt.from(10).pow(10) *
            (lineLength - BigInt.from(maxLineLength));
      }

      return minima[iAsInt] + (BigInt.from(maxLineLength) - lineLength).pow(2);
    }

    void smawk(Iterable<BigInt> rowsArg, Iterable<BigInt> columns) {
      Iterable<BigInt> rows = rowsArg;
      final stack = Queue<BigInt>();
      BigInt i = BigInt.zero;
      while (i < BigInt.from(rows.length)) {
        if (stack.isNotEmpty) {
          final BigInt c = columns.elementAt(stack.length - 1);
          if (cost(stack.last, c) < cost(rows.elementAt(i.toInt()), c)) {
            if (stack.length < columns.length) {
              stack.add(rows.elementAt(i.toInt()));
            }
            i += BigInt.one;
          } else {
            stack.removeFirst();
          }
        } else {
          stack.add(rows.elementAt(i.toInt()));
          i += BigInt.one;
        }
      }

      rows = stack.toList();

      if (columns.length > 1) {
        smawk(rows, columns.skip(1).take(1));
      }

      BigInt j;
      i = j = BigInt.zero;

      while (j < BigInt.from(columns.length)) {
        BigInt end;
        end = j + BigInt.one < BigInt.from(columns.length)
            ? breaks[columns.elementAt((j + BigInt.one).toInt()).toInt()]
            : rows.last;

        BigInt c =
            cost(rows.elementAt(i.toInt()), columns.elementAt(j.toInt()));

        if (c < minima[columns.elementAt(j.toInt()).toInt()]) {
          minima[columns.elementAt(j.toInt()).toInt()] = c;
          breaks[columns.elementAt(j.toInt()).toInt()] =
              rows.elementAt(i.toInt());
        }
        if (rows.elementAt(i.toInt()) < end) {
          i += BigInt.one;
        } else {
          j += BigInt.two;
        }
      }
    }

    Iterable<BigInt> range(BigInt a, BigInt b) {
      return List<BigInt>.generate(
        (b - a).toInt(),
        (index) => BigInt.from(index) + a,
      );
    }

    BigInt n = BigInt.from(wordsCount) + BigInt.one;
    BigInt i = BigInt.zero;
    BigInt offset = BigInt.zero;

    while (true) {
      BigInt r = BigInt.from(
        min<int>(n.toInt(), BigInt.two.pow(i.toInt() + 1).toInt()),
      );
      BigInt edge = BigInt.two.pow(i.toInt()) + offset;

      smawk(range(offset, edge), range(edge, r + offset));

      BigInt x = minima[(r - BigInt.one + offset).toInt()];

      bool flag = true;
      for (final j in range(BigInt.two.pow(i.toInt()), r - BigInt.one)) {
        BigInt y = cost(j + offset, r - BigInt.one + offset);

        if (y <= x) {
          n -= j;
          i = BigInt.zero;
          offset += j;
          flag = false;
          break;
        }
      }

      if (flag) {
        if (r == n) {
          break;
        }
        i += BigInt.one;
      }
    }

    final lines = <String>[];

    BigInt j = BigInt.from(wordsCount);
    while (j > BigInt.zero) {
      i = breaks[j.toInt()];
      lines.add(words.sublist(i.toInt(), j.toInt()).join(wordSeparation));
      j = i;
    }

    return lines.reversed.toList();
  }
}
