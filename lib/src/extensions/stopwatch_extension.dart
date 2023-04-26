import 'package:collection/collection.dart';

extension StopwatchExtension on Stopwatch {
  Duration? timeLeft(Duration? timeout, [Duration? absoluteTimeout]) => minBy(
        [timeout == null ? null : timeout - elapsed, absoluteTimeout]
            .expand<Duration>((e) => e == null ? [] : [e]),
        (e) => e,
      );
}
