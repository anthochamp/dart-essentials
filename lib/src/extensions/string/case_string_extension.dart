extension CaseStringExtension on String {
  String toTitleCase() {
    // ignore: avoid-substring
    return this[0].toUpperCase() + substring(1).toLowerCase();
  }

  int compareToI(String other) {
    return toLowerCase().compareTo(other.toLowerCase());
  }
}
