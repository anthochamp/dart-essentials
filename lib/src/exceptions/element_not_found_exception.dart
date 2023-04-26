class ElementNotFoundException implements Exception {
  final dynamic value;

  ElementNotFoundException(this.value);

  @override
  String toString() {
    return 'ElementNotFoundException: $value';
  }
}
