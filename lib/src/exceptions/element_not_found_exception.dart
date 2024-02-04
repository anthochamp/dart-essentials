// SPDX-FileCopyrightText: © 2023 - 2024 Anthony Champagne <dev@anthonychampagne.fr>
//
// SPDX-License-Identifier: BSD-3-Clause

class ElementNotFoundException implements Exception {
  final dynamic value;

  ElementNotFoundException(this.value);

  @override
  String toString() {
    return 'ElementNotFoundException: $value';
  }
}
