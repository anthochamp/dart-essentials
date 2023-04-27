// Copyright 2023, Anthony Champagne. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

class InvalidDataException implements Exception {
  final String message;
  final dynamic source;

  InvalidDataException(this.message, [this.source]);

  @override
  String toString() {
    String exception = 'InvalidDataException: $message';

    if (source != null) {
      exception += ', source = $source';
    }

    return exception;
  }
}
