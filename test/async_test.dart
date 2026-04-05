// SPDX-FileCopyrightText: © 2023 - 2026 Anthony Champagne <dev@anthonychampagne.fr>
//
// SPDX-License-Identifier: BSD-3-Clause

import 'dart:async';

import 'package:async/async.dart';
import 'package:test/test.dart';

import 'package:ac_dart_essentials/ac_dart_essentials.dart';

void main() {
  // ---------------------------------------------------------------------------
  // CancelableTimer
  // ---------------------------------------------------------------------------
  group('CancelableTimer.periodic', () {
    test('callback is invoked and tick increments', () async {
      final completer = Completer<void>();
      var ticks = 0;

      final timer = CancelableTimer.periodic(
        const Duration(milliseconds: 10),
        (t) {
          ticks = t.tick;
          if (ticks >= 3) {
            t.cancel();
            if (!completer.isCompleted) completer.complete();
          }
          return CancelableOperation.fromFuture(Future.value());
        },
      );

      await completer.future.timeout(const Duration(seconds: 2));
      expect(ticks, greaterThanOrEqualTo(3));
      expect(timer.isActive, isFalse);
    });

    test('cancel() stops further invocations', () async {
      var count = 0;

      final timer = CancelableTimer.periodic(
        const Duration(milliseconds: 20),
        (t) {
          count++;
          return CancelableOperation.fromFuture(Future.value());
        },
      );

      // Let at least one tick fire, then cancel.
      await Future.delayed(const Duration(milliseconds: 50));
      timer.cancel();
      final countAtCancel = count;

      // Wait to confirm no more ticks.
      await Future.delayed(const Duration(milliseconds: 80));
      expect(count, equals(countAtCancel));
      expect(timer.isActive, isFalse);
    });

    test('wait=false clears operation after completion (callback fires again)',
        () async {
      var callCount = 0;
      final completer = Completer<void>();

      CancelableTimer.periodic(
        const Duration(milliseconds: 30),
        (t) {
          callCount++;
          if (callCount >= 2) {
            t.cancel();
            if (!completer.isCompleted) completer.complete();
          }
          // Operation completes quickly (much less than the 30ms period).
          return CancelableOperation.fromFuture(Future.value());
        },
        wait: false,
      );

      // Should receive at least 2 callback invocations.
      await completer.future.timeout(const Duration(seconds: 2));
      expect(callCount, greaterThanOrEqualTo(2));
    });
  });
}
