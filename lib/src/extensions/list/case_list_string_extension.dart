import 'package:collection/collection.dart';

extension CaseListStringExtension on List<String> {
  bool equalsI(List<String> other) {
    return equals(other, const CaseInsensitiveEquality());
  }
}
