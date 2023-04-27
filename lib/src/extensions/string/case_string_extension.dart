// Copyright 2023, Anthony Champagne. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

extension CaseStringExtension on String {
  /// Upper-case first character, lower-case following characters
  ///
  /// NB. Non-unicode aware method.
  String toTitleCase() {
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
