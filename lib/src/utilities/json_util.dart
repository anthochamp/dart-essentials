// SPDX-FileCopyrightText: © 2023 - 2026 Anthony Champagne <dev@anthonychampagne.fr>
//
// SPDX-License-Identifier: BSD-3-Clause

import '../types/json.dart';

/// Cast a [JsonValue] to a [JsonObjectArray].
///
/// Throws if [value] is not a [JsonArray], or if any element is not a
/// [JsonObject].
JsonObjectArray castAsJsonObjectArray(JsonValue value) {
  // Pass through a json array to help dart cast mechanism.
  return (value as JsonArray).map<JsonObject>((e) => e as JsonObject).toList();
}

/// `lodash.get`-like accessor for deeply nested [JsonObject] values.
///
/// [path] may be a single [String] or [int] key, or an [Iterable] of keys for
/// nested access.
// ignore: no-object-declaration — path accepts String|int|Iterable intentionally
JsonValue jsonGet(JsonObject object, dynamic path) {
  Iterable<dynamic> list;
  if (path is String || path is int) {
    list = [path];
  } else {
    list = path as Iterable<dynamic>;
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

/// JSON utilities exposed as static methods.
///
/// Deprecated — use the equivalent top-level functions instead:
/// [castAsJsonObjectArray], [jsonGet].
@Deprecated('Use top-level castAsJsonObjectArray and jsonGet functions')
class JsonUtil {
  @Deprecated('Use castAsJsonObjectArray')
  // ignore: no-object-declaration — forwarding to top-level function
  static JsonCollection castAsCollection(JsonValue value) =>
      castAsJsonObjectArray(value);

  @Deprecated('Use jsonGet')
  // ignore: no-object-declaration — path accepts String|int|Iterable intentionally
  static JsonValue get(JsonObject object, dynamic path) =>
      jsonGet(object, path);
}
