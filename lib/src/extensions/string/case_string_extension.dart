// SPDX-FileCopyrightText: © 2023 - 2026 Anthony Champagne <dev@anthonychampagne.fr>
//
// SPDX-License-Identifier: BSD-3-Clause

extension CaseStringExtension on String {
  /// Upper-case first character, lower-case following characters
  ///
  /// Returns an empty string unchanged.
  ///
  /// NB. Non-unicode aware method.
  String toTitleCase() {
    if (isEmpty) return this;
    // ignore: avoid-substring
    return this[0].toUpperCase() + substring(1).toLowerCase();
  }

  /// Like `String.compareTo` but with case-insensitive comparaison
  ///
  /// NB. Non-unicode aware method.
  int compareToI(String other) {
    return toLowerCase().compareTo(other.toLowerCase());
  }
}
