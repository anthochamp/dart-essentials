// SPDX-FileCopyrightText: © 2023 - 2024 Anthony Champagne <dev@anthonychampagne.fr>
//
// SPDX-License-Identifier: BSD-3-Clause

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
