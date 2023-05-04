import 'package:test/test.dart';

import 'package:ac_dart_essentials/ac_dart_essentials.dart';

void main() {
  group('LineBreaking', () {
    test('1', () {
      expect('AAA BB CC DDDDD'.breakLine(6), equals(['AAA', 'BB CC', 'DDDDD']));
    });
  });
}
