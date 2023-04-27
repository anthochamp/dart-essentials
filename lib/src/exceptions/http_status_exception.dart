// Copyright 2023, Anthony Champagne. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:io';

class HttpStatusException extends HttpException {
  HttpStatusException({
    required int status,
    String? statusText,
    required Uri url,
  }) : super('$status${statusText == null ? '' : ' $statusText'}', uri: url);
}
