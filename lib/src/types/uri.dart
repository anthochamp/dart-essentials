// SPDX-FileCopyrightText: © 2023 - 2026 Anthony Champagne <dev@anthonychampagne.fr>
//
// SPDX-License-Identifier: BSD-3-Clause

/// URI query parameters map.
///
/// Values are `String | Iterable<String>` to match the contract of
/// [Uri.queryParametersAll]. Consumers that only set simple key-value pairs
/// may pass `Map<String, String>` directly (it is a subtype).
typedef UriQueryParameters = Map<String, Object>;
