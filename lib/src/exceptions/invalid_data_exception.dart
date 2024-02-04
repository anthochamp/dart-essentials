// SPDX-FileCopyrightText: © 2023 - 2024 Anthony Champagne <dev@anthonychampagne.fr>
//
// SPDX-License-Identifier: BSD-3-Clause

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
