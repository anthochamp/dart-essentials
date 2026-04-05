// SPDX-FileCopyrightText: © 2023 - 2026 Anthony Champagne <dev@anthonychampagne.fr>
//
// SPDX-License-Identifier: BSD-3-Clause

import 'dart:convert';

import 'package:test/test.dart';

import 'package:ac_dart_essentials/ac_dart_essentials.dart';

void main() {
  // ---------------------------------------------------------------------------
  // Memoizer
  // ---------------------------------------------------------------------------
  group('Memoizer', () {
    test('runOnce executes computation and returns value', () {
      final m = Memoizer<int>();
      final result = m.runOnce(() => 42);
      expect(result, equals(42));
      expect(m.value, equals(42));
      expect(m.hasRun, isTrue);
    });

    test('runOnce is idempotent — computation called only once', () {
      var callCount = 0;
      final m = Memoizer<int>();
      m.runOnce(() {
        callCount++;
        return 1;
      });
      m.runOnce(() {
        callCount++;
        return 2;
      });
      expect(callCount, equals(1));
      expect(m.value, equals(1));
    });

    test('value before runOnce throws StateError', () {
      final m = Memoizer<int>();
      expect(() => m.value, throwsStateError);
    });

    test('hasRun is false before runOnce', () {
      expect(Memoizer<String>().hasRun, isFalse);
    });
  });

  // ---------------------------------------------------------------------------
  // StringPointer
  // ---------------------------------------------------------------------------
  group('StringPointer', () {
    test('initial offset is 0 and value equals full string', () {
      final ptr = StringPointer('hello');
      expect(ptr.offset, equals(0));
      expect(ptr.value, equals('hello'));
      expect(ptr.length, equals(5));
    });

    test('operator+ returns a new pointer (pure)', () {
      final ptr = StringPointer('hello');
      final next = ptr + 2;
      expect(ptr.offset, equals(0), reason: 'original must not be mutated');
      expect(next.offset, equals(2));
      expect(next.value, equals('llo'));
    });

    test('operator- returns a new pointer (pure)', () {
      final ptr = StringPointer('hello');
      final advanced = ptr + 4;
      final back = advanced - 2;
      expect(advanced.offset, equals(4),
          reason: 'advanced must not be mutated');
      expect(back.offset, equals(2));
      expect(back.value, equals('llo'));
    });

    test('overflow is true when offset >= length', () {
      final ptr = StringPointer('hi');
      expect((ptr + 2).overflow, isTrue);
      expect((ptr + 3).overflow, isTrue);
      expect((ptr + 1).overflow, isFalse);
    });

    test('value is clamped to string length', () {
      final ptr = StringPointer('abc');
      expect((ptr + 10).value, equals(''));
    });

    test('setting offset invalidates value cache', () {
      final ptr = StringPointer('hello');
      expect(ptr.value, equals('hello'));
      ptr.offset = 3;
      expect(ptr.value, equals('lo'));
    });
  });

  // ---------------------------------------------------------------------------
  // Duration top-level functions
  // ---------------------------------------------------------------------------
  group('durationMin', () {
    test('returns smaller duration', () {
      expect(
        durationMin(const Duration(seconds: 1), const Duration(seconds: 2)),
        equals(const Duration(seconds: 1)),
      );
    });

    test('with ignoreNull=true, null treated as infinity', () {
      expect(
        durationMin(null, const Duration(seconds: 5)),
        equals(const Duration(seconds: 5)),
      );
      expect(
        durationMin(const Duration(seconds: 5), null),
        equals(const Duration(seconds: 5)),
      );
    });

    test('both null returns null', () {
      expect(durationMin(null, null), isNull);
    });

    test('with ignoreNull=false, any null returns null', () {
      expect(
        durationMin(null, const Duration(seconds: 1), ignoreNull: false),
        isNull,
      );
    });
  });

  group('durationMax', () {
    test('returns larger duration', () {
      expect(
        durationMax(const Duration(seconds: 1), const Duration(seconds: 2)),
        equals(const Duration(seconds: 2)),
      );
    });

    test('with ignoreNull=true, null treated as zero/ignored', () {
      expect(
        durationMax(null, const Duration(seconds: 5)),
        equals(const Duration(seconds: 5)),
      );
    });
  });

  group('durationAdd', () {
    test('adds two durations', () {
      expect(
        durationAdd(const Duration(seconds: 1), const Duration(seconds: 2)),
        equals(const Duration(seconds: 3)),
      );
    });

    test('returns null when either is null by default', () {
      expect(durationAdd(null, const Duration(seconds: 1)), isNull);
      expect(durationAdd(const Duration(seconds: 1), null), isNull);
    });

    test('with nullIsZero=true, null treated as zero', () {
      expect(
        durationAdd(null, const Duration(seconds: 3), nullIsZero: true),
        equals(const Duration(seconds: 3)),
      );
    });
  });

  group('durationSubtract', () {
    test('subtracts two durations', () {
      expect(
        durationSubtract(
          const Duration(seconds: 5),
          const Duration(seconds: 2),
        ),
        equals(const Duration(seconds: 3)),
      );
    });

    test('returns null when either is null by default', () {
      expect(durationSubtract(null, const Duration(seconds: 1)), isNull);
    });

    test('with nullIsZero=true, null a returns negated b', () {
      expect(
        durationSubtract(null, const Duration(seconds: 3), nullIsZero: true),
        equals(const Duration(seconds: -3)),
      );
    });
  });

  group('durationLt/Lte/Gt/Gte/Equal', () {
    const d = Duration(seconds: 10);

    test('durationLt', () {
      expect(durationLt(const Duration(seconds: 5), d), isTrue);
      expect(durationLt(const Duration(seconds: 15), d), isFalse);
      expect(durationLt(null, d), isNull);
    });

    test('durationGt', () {
      expect(durationGt(const Duration(seconds: 15), d), isTrue);
      expect(durationGt(null, d), isNull);
    });

    test('durationEqual', () {
      expect(durationEqual(d, d), isTrue);
      expect(durationEqual(Duration.zero, d), isFalse);
      expect(durationEqual(null, d), isNull);
    });
  });

  // ---------------------------------------------------------------------------
  // jsonGet + castAsJsonObjectArray
  // ---------------------------------------------------------------------------
  group('jsonGet', () {
    test('accesses string key', () {
      expect(jsonGet({'a': 1}, 'a'), equals(1));
    });

    test('accesses integer index', () {
      expect(
          jsonGet({
            'list': [10, 20, 30]
          }, [
            'list',
            1,
          ]),
          equals(20));
    });

    test('accesses nested path', () {
      final obj = {
        'user': {'name': 'Alice', 'age': 30},
      };
      expect(jsonGet(obj, ['user', 'name']), equals('Alice'));
    });

    test('returns null from missing key (nullable map value)', () {
      expect(jsonGet({'a': null}, 'a'), isNull);
    });

    test('throws on invalid type (non-map for string key access)', () {
      expect(() => jsonGet({'list': 1}, ['list', 'nested']), throwsA(anything));
    });
  });

  group('castAsJsonObjectArray', () {
    test('casts list of objects', () {
      final result = castAsJsonObjectArray([
        {'a': 1},
        {'b': 2},
      ]);
      expect(result, hasLength(2));
      expect(result.first, equals({'a': 1}));
    });

    test('throws for non-array value', () {
      expect(() => castAsJsonObjectArray('not a list'), throwsA(anything));
    });
  });

  // ---------------------------------------------------------------------------
  // Inspect
  // ---------------------------------------------------------------------------
  group('Inspect', () {
    late Inspect inspect;

    setUp(() => inspect = const Inspect());

    test('inspects a string with quotes', () {
      const i = Inspect(InspectOptions(stringQuotes: '"'));
      expect(i.inspect('hello'), equals('"hello"'));
    });

    test('inspects a number', () {
      expect(inspect.inspect(42), equals('42'));
    });

    test('inspects a list compactly', () {
      expect(inspect.inspect([1, 2, 3]), equals('[1, 2, 3]'));
    });

    test('inspects a list with truncation marker', () {
      const i = Inspect(InspectOptions(maxListSetLength: 2));
      // ignore: avoid-non-ascii-symbols
      expect(inspect.inspect([1, 2]), isNot(contains('…')));
      // ignore: avoid-non-ascii-symbols
      expect(i.inspect([1, 2, 3]), contains('…'));
    });

    test('works on lazy Iterable without .length', () {
      final lazy = Iterable.generate(100, (i) => i);
      const i = Inspect(InspectOptions(maxListSetLength: 5));
      // Must not throw; should contain truncation marker.
      // ignore: avoid-non-ascii-symbols
      expect(i.inspect(lazy), contains('…'));
    });

    test('inspects a map', () {
      expect(inspect.inspect({'key': 'val'}), contains('key'));
    });

    test('inspects null as "null"', () {
      expect(inspect.inspect(null), equals('null'));
    });
  });

  // ---------------------------------------------------------------------------
  // ConverterPassthroughSink
  // ---------------------------------------------------------------------------
  group('ConverterPassthroughSink', () {
    test('converts and forwards data', () {
      final collected = <String>[];
      // ignore: close_sinks — output is closed transitively when sink is closed
      final output = _CollectSink(collected);
      final sink = ConverterPassthroughSink(
        const Utf8Decoder(),
        output,
      );
      addTearDown(sink.close);
      sink.add([104, 101, 108, 108, 111]); // "hello" in UTF-8
      expect(collected, equals(['hello']));
    });

    test('close propagates and prevents further adds', () {
      // ignore: close_sinks — output is closed transitively when sink.close() is called
      final output = _CollectSink(<String>[]);
      final sink = ConverterPassthroughSink(const Utf8Decoder(), output);
      sink.close();
      expect(() => sink.add([65]), throwsStateError);
    });
  });
}

// Helper sink used by ConverterPassthroughSink tests
class _CollectSink implements Sink<String> {
  _CollectSink(this._collected);

  final List<String> _collected;
  bool _closed = false;

  @override
  void add(String data) => _collected.add(data);

  @override
  void close() => _closed = true;

  bool get isClosed => _closed;
}
