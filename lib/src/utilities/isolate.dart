// SPDX-FileCopyrightText: © 2023 - 2024 Anthony Champagne <dev@anthonychampagne.fr>
//
// SPDX-License-Identifier: BSD-3-Clause

import 'dart:isolate';

SendPort createIsolateErrorListener(
  void Function(Object, StackTrace?) onIsolateError,
) {
  return RawReceivePort((List<dynamic> errorStackTracePair) {
    onIsolateError(
      errorStackTracePair.first,
      errorStackTracePair.last == null
          ? null
          : StackTrace.fromString(errorStackTracePair.last),
    );
  }).sendPort;
}
