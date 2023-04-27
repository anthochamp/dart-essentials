import 'package:test/test.dart';

import 'package:anthochamp_dart_essentials/src/extensions/runes/line_breaking_string_extension.dart';

void main() {
  group('LineBreaking', () {
    test('1', () {
      expect('AAA BB CC DDDDD'.breakLine(6), equals(['AAA', 'BB CC', 'DDDDD']));
    });
  });
}
