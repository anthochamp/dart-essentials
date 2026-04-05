# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/), and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added

- `IsolateErrorListener` record typedef: `({SendPort sendPort, void Function() close})`
- `JsonObjectArray` typedef (`List<JsonObject>`)
- Top-level `durationMin`, `durationMax`, `durationAdd`, `durationSubtract`, `durationLt`,
  `durationLte`, `durationGt`, `durationGte`, `durationEqual` functions
- Top-level `castAsJsonObjectArray` and `jsonGet` functions
- `PatternExtensions.captureGroup([String? name])` — replaces removed `namedCapture`
- `platform_independent.dart` export file (corrects the `platform_independant.dart` spelling)
- `Inspect` constructor is now `const`
- `Memoizer.value` now throws `StateError` when accessed before `runOnce`

### Changed

- `createIsolateErrorListener` now returns `IsolateErrorListener` instead of `SendPort`; use
  `.sendPort` to pass to `Isolate.addErrorListener` and call `.close()` when the isolate exits
- `StringPointer.operator+` / `operator-` now return a new `StringPointer` instance instead of
  mutating `_offset`; use `pointer.offset += n` to advance in place
- `JsonNumber` changed from `double` to `num` — correctly handles integer JSON numbers decoded
  by `dart:convert`
- `UriQueryParameters` changed from `Map<String, dynamic>` to `Map<String, Object>`
- `DurationUtil` static methods moved to top-level `duration*` functions; class retained as
  `@Deprecated` forwarding shim
- `JsonUtil.castAsCollection` / `JsonUtil.get` moved to top-level `castAsJsonObjectArray` /
  `jsonGet`; class retained as `@Deprecated` forwarding shim
- `ConverterPassthroughSink` changed from `extends Sink<S>` to `implements Sink<S>`
- SDK minimum constraint raised from `>=2.19.5` to `>=3.0.0`

### Deprecated

- `JsonCollection` — use `JsonObjectArray` instead
- `DurationUtil` class — use the top-level `duration*` functions instead
- `JsonUtil` class — use `castAsJsonObjectArray` / `jsonGet` instead

### Removed

- `PatternExtensions.namedCapture` — use `captureGroup` instead
- `platform_independant.dart` export file (misspelling; replaced by `platform_independent.dart`)

### Fixed

- `CaseStringExtension.toTitleCase()` — no longer throws `RangeError` on empty strings
- `truncate` — now throws `ArgumentError` for negative `maxLength` (was a stripped `assert`)
- `PatternExtensions.entireMatch` / `entireMatchI` — now correctly handles `RegExp` inputs by
  extracting `.pattern`; previously used `toString()` which produced malformed regex literals
- `PatternTrimStringExtension.patternTrimLeft` / `patternTrimRight` — same `RegExp` source fix
- `Inspect._inspectValue` — uses `take(n+1).length > n` instead of `.length` to avoid O(n)
  evaluation of lazy `Iterable`s
- `DataHistorySink.add` — window eviction condition corrected from `>` to `>=`; was keeping one
  extra element when the buffer was exactly at window size

## 0.2.3

- Upgrade ac_lints package to 0.4.0

## 0.2.2

- Upgrade ac_lints package to 0.3.0

## 0.2.1

- Update LICENSE's copyright to include contributors and use SPDX file header
- Widen SDK environment requirement to include Dart 3 versions
- Upgrade ac_lints package to 0.2.0

## 0.2.0

- fix exports
- add String.prependLines extension

## 0.1.0

- Initial release
