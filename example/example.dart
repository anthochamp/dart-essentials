// SPDX-FileCopyrightText: © 2026 Anthony Champagne <dev@anthonychampagne.fr>
//
// SPDX-License-Identifier: BSD-3-Clause

// ignore_for_file: avoid_print

import 'package:ac_dart_essentials/ac_dart_essentials.dart';

void main() {
  _memoizerExample();
  _stringExtensionsExample();
  _durationUtilExample();
  _truncateExample();
}

void _memoizerExample() {
  print('--- Memoizer ---');

  final memoizer = Memoizer<String>();
  int computations = 0;

  String compute() {
    computations++;
    return 'hello';
  }

  final first = memoizer.runOnce(compute);
  final second = memoizer.runOnce(compute);

  print('Value: $first');
  print('Same value on second call: ${first == second}');
  print('compute() called only once: ${computations == 1}'); // true
}

void _stringExtensionsExample() {
  print('\n--- String extensions ---');

  const title = 'hello world';
  print(title.toTitleCase()); // Hello world

  const a = 'Apple';
  const b = 'apple';
  print('compareToI: ${a.compareToI(b)}'); // 0 — case-insensitive equal
}

void _durationUtilExample() {
  print('\n--- Duration utilities ---');

  const short = Duration(seconds: 5);
  const long = Duration(seconds: 30);

  print('min(5s, 30s): ${durationMin(short, long)}'); // 0:00:05.000000
  print('max(5s, 30s): ${durationMax(short, long)}'); // 0:00:30.000000

  // null is treated as "infinity" by default
  print('min(5s, null): ${durationMin(short, null)}'); // 0:00:05.000000
  print('max(null, 30s): ${durationMax(null, long)}'); // 0:00:30.000000
}

void _truncateExample() {
  print('\n--- String truncation ---');

  const text = 'The quick brown fox jumps over the lazy dog';

  print(text.truncate(maxLength: 15)); // The quick brown…
  print(
    text.truncate(
      maxLength: 15,
      breakWord: false,
    ),
  ); // The quick…
  print(
    text.truncate(
      maxLength: 15,
      position: TruncatePosition.center,
    ),
  ); // The quic…zy dog
  print(
    text.truncate(
      maxLength: 15,
      position: TruncatePosition.start,
    ),
  ); // …er the lazy dog
}
