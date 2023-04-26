import 'package:dart_essentials/src/extensions/runes/line_breaking_string_extension.dart';
import 'package:test/test.dart';


void main() {
  group('LineBreaking', () {
    test('1', () {
      expect('AAA BB CC DDDDD'.breakLine(6), equals(['AAA', 'BB CC', 'DDDDD']));
    });
  });
}
