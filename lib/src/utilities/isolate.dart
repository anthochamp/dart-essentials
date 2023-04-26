import 'dart:isolate';

SendPort createIsolateErrorListener(
  void Function(Object, StackTrace?) onIsolateError,
) {
  return RawReceivePort((List<dynamic> errorStackTracePair) {
    onIsolateError(
      errorStackTracePair.first,
      errorStackTracePair.last == null
          ? null
          : StackTrace.fromString(errorStackTracePair.last),
    );
  }).sendPort;
}
