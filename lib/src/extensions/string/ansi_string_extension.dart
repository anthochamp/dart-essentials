extension AnsiStringExtension on String {
  String removeAnsiChars() =>
      replaceAll(RegExp(r'(\x9B|\x1B\[)[0-?]*[ -\/]*[@-~]'), '');
}
