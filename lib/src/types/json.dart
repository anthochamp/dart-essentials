// SPDX-FileCopyrightText: © 2023 - 2026 Anthony Champagne <dev@anthonychampagne.fr>
//
// SPDX-License-Identifier: BSD-3-Clause

typedef JsonValue = Object?;
typedef JsonString = String;

/// A JSON number. May be decoded as `int` or `double` by `dart:convert`.
typedef JsonNumber = num;
typedef JsonObject = Map<JsonString, JsonValue>;

/// A JSON array that may contain any [JsonValue] element.
typedef JsonArray = List<JsonValue>;

/// A JSON array whose elements are all [JsonObject]s.
///
/// Use [JsonArray] for arrays of arbitrary JSON values.
typedef JsonObjectArray = List<JsonObject>;

/// @deprecated Use [JsonObjectArray] instead.
typedef JsonCollection = JsonObjectArray;

typedef JsonMap = JsonObject;
