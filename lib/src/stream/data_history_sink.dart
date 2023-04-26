import 'dart:collection';

class DataHistorySink<T> extends Sink<T> {
  DataHistorySink([int? initialWindowSize]) : _windowSize = initialWindowSize;

  final _buffer = Queue<T>();
  int? _windowSize;
  bool _closed = false;

  Iterable<T> get buffer => _buffer;

  int? get windowSize => _windowSize;

  set windowSize(int? size) {
    _windowSize = size;

    while (size != null && _buffer.length > size) {
      _buffer.removeFirst();
    }
  }

  @override
  void add(T data) {
    if (_closed) throw StateError('Sink closed');

    while (_windowSize != null && _buffer.length > _windowSize!) {
      _buffer.removeFirst();
    }

    _buffer.add(data);
  }

  @override
  void close() {
    _closed = true;
  }
}
