import 'dart:io';

import 'package:futaba_client/api/parser/catalog_parser.dart';
import 'package:test/test.dart';

import '../utils/test_path.dart';

void main() {
  group('CatalogParser', () {
    test('正常にパースできること', () {
      final body = File(testPath('fixtures/catalog.html')).readAsStringSync();
      final input = CatalogParserInput(Uri.https('example.com', '/b/'), body);
      final output = parseCatalog(input);
      expect(output.threads.length, 4);
      expect(output.threads[0].id, '10000001');
      expect(output.threads[0].url,
          Uri.https('example.com', '/b/res/10000001.htm'));
      expect(output.threads[0].thumbnailUrl,
          Uri.https('example.com', '/b/cat/10000001s.jpg'));
      expect(output.threads[0].replyCount, 11);
      expect(output.threads[0].body, 'Body1');
      expect(output.error, isNull);
    });

    test('情報に不足があってもパースは成功すること', () {
      const body = '''
<html><head></head><body><table id='cattable'><tr>
<td>アンカータグは必須のためこのtdは無視される</td>
<td><a href="res/12345678.htm"></a></td>
</tr></table></body></html>
      ''';
      final input = CatalogParserInput(Uri.https('example.com', '/b/'), body);
      final output = parseCatalog(input);
      expect(output.threads.length, 1);
      expect(output.threads[0].id, '12345678');
      expect(output.threads[0].url,
          Uri.https('example.com', '/b/res/12345678.htm'));
      expect(output.threads[0].thumbnailUrl, isNull);
      expect(output.threads[0].replyCount, isNull);
      expect(output.threads[0].body, isNull);
      expect(output.error, isNull);
    });

    test('bodyが空の場合エラーが返ること', () {
      const body = '<html><head></head><body></body></html>';
      final input = CatalogParserInput(Uri.https('example.com', '/b/'), body);
      final output = parseCatalog(input);
      expect(output.threads.isEmpty, true);
      expect(output.error, isNotNull);
    });
  });
}
