// Copyright 2023, Anthony Champagne. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

class ElementNotFoundException implements Exception {
  final dynamic value;

  ElementNotFoundException(this.value);

  @override
  String toString() {
    return 'ElementNotFoundException: $value';
  }
}
