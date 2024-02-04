// SPDX-FileCopyrightText: © 2023 - 2024 Anthony Champagne <dev@anthonychampagne.fr>
//
// SPDX-License-Identifier: BSD-3-Clause

import 'package:collection/collection.dart';

extension CaseListStringExtension on List<String> {
  /// like `List<String>.equals` but compares using case-insensitive equality.
  bool equalsI(List<String> other) {
    return equals(other, const CaseInsensitiveEquality());
  }
}
