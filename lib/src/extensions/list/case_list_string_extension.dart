// Copyright 2023, Anthony Champagne. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:collection/collection.dart';

extension CaseListStringExtension on List<String> {
  /// like `List<String>.equals` but compares using case-insensitive equality.
  bool equalsI(List<String> other) {
    return equals(other, const CaseInsensitiveEquality());
  }
}
