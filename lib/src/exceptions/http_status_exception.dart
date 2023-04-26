import 'dart:io';

class HttpStatusException extends HttpException {
  HttpStatusException({
    required int status,
    String? statusText,
    required Uri url,
  }) : super('$status${statusText == null ? '' : ' $statusText'}', uri: url);
}
