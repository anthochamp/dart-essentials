// Copyright 2023, Anthony Champagne. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:convert';

class ConverterPassthroughSink<S, T, C extends Converter<S, T>>
    extends Sink<S> {
  ConverterPassthroughSink(this._converter, this._output);

  final Sink<T> _output;
  final C _converter;
  bool _closed = false;

  @override
  void add(S data) {
    if (_closed) throw StateError('Sink closed');

    _output.add(_converter.convert(data));
  }

  @override
  void close() {
    _output.close();
    _closed = true;
  }
}
