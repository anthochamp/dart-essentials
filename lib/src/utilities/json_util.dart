// SPDX-FileCopyrightText: © 2023 - 2024 Anthony Champagne <dev@anthonychampagne.fr>
//
// SPDX-License-Identifier: BSD-3-Clause

import '../types/json.dart';

class JsonUtil {
  /// Cast a `JsonValue` to a `JsonCollection`
  ///
  /// It'll throw if `value` is not a `JsonArray`, or if array's elements are not `JsonObject`.
  static JsonCollection castAsCollection(JsonValue value) {
    // pass through an json array to help dart cast mechanism
    return (value as JsonArray)
        .map<JsonObject>((e) => e as JsonObject)
        .toList();
  }

  /// `lodash.get`-like method
  // ignore: no-object-declaration
  static JsonValue get(JsonObject object, dynamic path) {
    Iterable<dynamic> list;
    if (path is String || path is int) {
      list = [path];
    } else {
      list = path;
    }

    JsonValue result = object;
    for (final segment in list) {
      if (segment is int) {
        result = (result as JsonArray).elementAt(segment);
      } else {
        result = (result as JsonObject)[segment.toString()];
      }
    }

    return result;
  }
}
