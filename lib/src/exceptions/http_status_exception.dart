// SPDX-FileCopyrightText: © 2023 - 2024 Anthony Champagne <dev@anthonychampagne.fr>
//
// SPDX-License-Identifier: BSD-3-Clause

import 'dart:io';

class HttpStatusException extends HttpException {
  HttpStatusException({
    required int status,
    String? statusText,
    required Uri url,
  }) : super('$status${statusText == null ? '' : ' $statusText'}', uri: url);
}
