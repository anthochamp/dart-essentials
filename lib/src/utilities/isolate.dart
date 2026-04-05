// SPDX-FileCopyrightText: © 2023 - 2026 Anthony Champagne <dev@anthonychampagne.fr>
//
// SPDX-License-Identifier: BSD-3-Clause

import 'dart:isolate';

/// A listener that forwards isolate errors from [sendPort] to [onIsolateError].
///
/// Call [close] when the isolate exits to release the underlying [RawReceivePort].
typedef IsolateErrorListener = ({SendPort sendPort, void Function() close});

/// Creates a [IsolateErrorListener] that calls [onIsolateError] when the
/// associated isolate encounters an unhandled error.
///
/// Assign [IsolateErrorListener.sendPort] to `Isolate.addErrorListener`.
/// Call [IsolateErrorListener.close] after the isolate is done to release
/// the underlying [RawReceivePort].
IsolateErrorListener createIsolateErrorListener(
  void Function(Object, StackTrace?) onIsolateError,
) {
  final port = RawReceivePort((List<dynamic> errorStackTracePair) {
    onIsolateError(
      errorStackTracePair.first,
      errorStackTracePair.last == null
          ? null
          : StackTrace.fromString(errorStackTracePair.last),
    );
  });
  return (sendPort: port.sendPort, close: port.close);
}
