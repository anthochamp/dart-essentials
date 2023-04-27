// Copyright 2023, Anthony Champagne. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import '../utilities/inspect.dart';

extension InspectStringExtension on String {
  /// Node.js's `inspect`-like method
  String inspect([InspectOptions? options]) => Inspect(options).inspect(this);
}

extension InspectListExtension on List {
  /// Node.js's `inspect`-like method
  String inspect([InspectOptions? options]) => Inspect(options).inspect(this);
}

extension InspectSetExtension on Set {
  /// Node.js's `inspect`-like method
  String inspect([InspectOptions? options]) => Inspect(options).inspect(this);
}

extension InspectMapExtension on Map {
  /// Node.js's `inspect`-like method
  String inspect([InspectOptions? options]) => Inspect(options).inspect(this);
}
