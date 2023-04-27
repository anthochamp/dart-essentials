// Copyright 2023, Anthony Champagne. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

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
