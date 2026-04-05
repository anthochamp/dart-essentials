// SPDX-FileCopyrightText: © 2023 - 2026 Anthony Champagne <dev@anthonychampagne.fr>
//
// SPDX-License-Identifier: BSD-3-Clause

import 'package:test/test.dart';

import 'package:ac_dart_essentials/ac_dart_essentials.dart';

void main() {
  // ---------------------------------------------------------------------------
  // StopwatchExtension.timeLeft
  // ---------------------------------------------------------------------------
  group('StopwatchExtension.timeLeft', () {
    test('returns null when both arguments are null', () {
      final sw = Stopwatch()..start();
      expect(sw.timeLeft(null), isNull);
    });

    test('returns absoluteTimeout when timeout is null', () {
      final sw = Stopwatch()..start();
      expect(
        sw.timeLeft(null, const Duration(seconds: 60)),
        equals(const Duration(seconds: 60)),
      );
    });

    test('returns remaining timeout minus elapsed', () {
      final sw = Stopwatch()..start();
      // elapsed should be < 100 ms in any reasonable test runner
      final left = sw.timeLeft(const Duration(seconds: 10));
      expect(left, isNotNull);
      expect(left!.inMilliseconds, lessThanOrEqualTo(10000));
      expect(left.inMilliseconds, greaterThan(9000));
    });

    test('returns minimum of timeout remainder and absoluteTimeout', () {
      final sw = Stopwatch()..start();
      final left = sw.timeLeft(
        const Duration(seconds: 10),
        const Duration(seconds: 3),
      );
      expect(left, equals(const Duration(seconds: 3)));
    });
  });

  // ---------------------------------------------------------------------------
  // PatternExtensions
  // ---------------------------------------------------------------------------
  group('PatternExtensions.entireMatch', () {
    test('matches whole string', () {
      expect('hello'.entireMatch('hello'), isTrue);
    });

    test('does not match partial string', () {
      expect('hello'.entireMatch('hell'), isFalse);
    });

    test('works with RegExp pattern', () {
      expect(RegExp(r'\d+').entireMatch('123'), isTrue);
      expect(RegExp(r'\d+').entireMatch('12x'), isFalse);
    });

    test('does not inject RegExp toString() representation for RegExp patterns',
        () {
      // RegExp.toString() yields "/pattern/"; entireMatch must use .pattern
      expect(RegExp(r'[a-z]+').entireMatch('abc'), isTrue);
    });
  });

  group('PatternExtensions.entireMatchI', () {
    test('matches case-insensitively', () {
      expect('hello'.entireMatchI('HELLO'), isTrue);
      expect(RegExp('[a-z]+').entireMatchI('ABC'), isTrue);
    });
  });

  group('PatternExtensions.captureGroup', () {
    test('without name produces non-capturing group', () {
      expect('foo'.captureGroup(), equals('(?:foo)'));
    });

    test('with name produces named capture group', () {
      expect('foo'.captureGroup('bar'), equals('(?<bar>foo)'));
    });

    test('RegExp: uses pattern source not toString()', () {
      expect(RegExp(r'\d+').captureGroup('num'), equals(r'(?<num>\d+)'));
    });
  });

  group('PatternExtensions.inoutCapture', () {
    test('wraps with pre/post pattern and nested capture groups', () {
      final result = 'foo'.inoutCapture(
        prePattern: '"',
        postPattern: '"',
        inCaptureName: 'inner',
        outCaptureName: 'outer',
      );
      expect(result, equals('(?<outer>"(?<inner>foo)")'));
    });

    test('without names wraps in non-capturing groups', () {
      final result = 'x'.inoutCapture(prePattern: '(', postPattern: ')');
      expect(result, startsWith('(?:'));
    });
  });

  // ---------------------------------------------------------------------------
  // PatternTrimStringExtension
  // ---------------------------------------------------------------------------
  group('PatternTrimStringExtension', () {
    test('patternTrimLeft removes leading match', () {
      expect('  hello'.patternTrimLeft(' '), equals(' hello'));
      expect('  hello'.patternTrimLeft(RegExp(r'\s+')), equals('hello'));
    });

    test('patternTrimRight removes trailing match', () {
      expect('hello  '.patternTrimRight(' '), equals('hello '));
      expect('hello  '.patternTrimRight(RegExp(r'\s+')), equals('hello'));
    });

    test('patternTrim removes both sides', () {
      expect('  hi  '.patternTrim(RegExp(r'\s+')), equals('hi'));
    });

    test('no-op when pattern not present', () {
      expect('hello'.patternTrim('x'), equals('hello'));
    });

    test('RegExp: uses pattern source not toString()', () {
      // Without the fix, RegExp(r'\s+').toString() == "/\s+/" which would not match.
      expect('  hi  '.patternTrim(RegExp(r'\s+')), equals('hi'));
    });
  });

  // ---------------------------------------------------------------------------
  // CaseStringExtension
  // ---------------------------------------------------------------------------
  group('CaseStringExtension', () {
    test('toTitleCase capitalises first, lowercases rest', () {
      expect('hELLO'.toTitleCase(), equals('Hello'));
    });

    test('toTitleCase on empty string returns empty string', () {
      expect(''.toTitleCase(), equals(''));
    });

    test('compareToI compares case-insensitively', () {
      expect('Hello'.compareToI('hello'), equals(0));
      expect('a'.compareToI('B'), isNegative);
      expect('Z'.compareToI('a'), isPositive);
    });
  });

  // ---------------------------------------------------------------------------
  // LinesStringExtension
  // ---------------------------------------------------------------------------
  group('LinesStringExtension.prependLines', () {
    test('prepends prefix to every line', () {
      expect('a\nb\nc'.prependLines('> '), equals('> a\n> b\n> c'));
    });

    test('single-line string', () {
      expect('hello'.prependLines('- '), equals('- hello'));
    });
  });

  // ---------------------------------------------------------------------------
  // AnsiStringExtension
  // ---------------------------------------------------------------------------
  group('AnsiStringExtension.removeAnsiChars', () {
    test('removes SGR escape sequence', () {
      expect('\x1B[32mhello\x1B[0m'.removeAnsiChars(), equals('hello'));
    });

    test('leaves plain string unchanged', () {
      expect('plain text'.removeAnsiChars(), equals('plain text'));
    });
  });

  // ---------------------------------------------------------------------------
  // CaseListStringExtension
  // ---------------------------------------------------------------------------
  group('CaseListStringExtension.equalsI', () {
    test('returns true for identical lists', () {
      expect(['a', 'b'].equalsI(['a', 'b']), isTrue);
    });

    test('returns true for case-insensitively equal lists', () {
      expect(['Hello', 'World'].equalsI(['hello', 'world']), isTrue);
    });

    test('returns false for different content', () {
      expect(['a'].equalsI(['b']), isFalse);
    });

    test('returns false for different lengths', () {
      expect(['a', 'b'].equalsI(['a']), isFalse);
    });
  });

  // ---------------------------------------------------------------------------
  // DataHistorySink
  // ---------------------------------------------------------------------------
  group('DataHistorySink', () {
    test('collects items in order', () {
      final sink = DataHistorySink<int>();
      addTearDown(sink.close);
      sink.add(1);
      sink.add(2);
      sink.add(3);
      expect(sink.buffer.toList(), equals([1, 2, 3]));
    });

    test('unbounded by default', () {
      final sink = DataHistorySink<int>();
      addTearDown(sink.close);
      for (var i = 0; i < 100; i++) {
        sink.add(i);
      }
      expect(sink.buffer.length, equals(100));
    });

    test('sliding window drops oldest items', () {
      final sink = DataHistorySink<int>(3);
      addTearDown(sink.close);
      sink.add(1);
      sink.add(2);
      sink.add(3);
      sink.add(4);
      expect(sink.buffer.toList(), equals([2, 3, 4]));
    });

    test('windowSize setter shrinks buffer immediately', () {
      final sink = DataHistorySink<int>();
      addTearDown(sink.close);
      for (var i = 1; i <= 5; i++) {
        sink.add(i);
      }
      sink.windowSize = 2;
      expect(sink.buffer.toList(), equals([4, 5]));
    });

    test('windowSize setter grow does not affect existing items', () {
      final sink = DataHistorySink<int>(2);
      addTearDown(sink.close);
      sink.add(1);
      sink.add(2);
      sink.windowSize = 5;
      expect(sink.buffer.toList(), equals([1, 2]));
    });

    test('add after close throws StateError', () {
      final sink = DataHistorySink<int>();
      sink.close();
      expect(() => sink.add(1), throwsStateError);
    });
  });
}
