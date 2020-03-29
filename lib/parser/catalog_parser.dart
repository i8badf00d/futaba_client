import 'package:futaba_client/entity/futaba_thread.dart';
import 'package:html/dom.dart';

class CatalogParserInput {
  CatalogParserInput(this.baseUrl, this.responseBody);
  final Uri baseUrl;
  final String responseBody;
}

class CatalogParserOutput {
  CatalogParserOutput(this.threads, this.error);
  final List<FutabaThread> threads;
  final CatalogParserError error;
}

class CatalogParserError extends Error {}

final RegExp _regExp = RegExp(r'(\d+)');

CatalogParserOutput parseCatalog(CatalogParserInput input) {
  try {
    final document = Document.html(input.responseBody);
    final tds = document.querySelector('#cattable').querySelectorAll('td');
    final threads = tds.map<FutabaThread>((td) {
      /*
        <td>
          <a href='res/687222066.htm' target='_blank'>
            <img src='/b/cat/1574521299328s.jpg' border=0 width=50 height=31 alt="">
          </a>
          <br>
          <small>ｷﾀ━━━</small>
          <br>
          <font size=2>3</font>
        </td>
      */
      final href = td.querySelector('a').attributes['href'];
      print('href: $href');
      final threadUrl = input.baseUrl.resolve(href);
      print('threadUrl: $threadUrl');
      final idMatch = _regExp.firstMatch(href);
      print('idMatch.groupCount: ${idMatch.groupCount}');
      final id = idMatch.group(idMatch.groupCount - 1);
      print('id: $id');

      final img = td.querySelector('img')?.attributes['src'];
      print('img: $img');
      final thumbnailUrl =
          img != null && img.isNotEmpty ? input.baseUrl.resolve(img) : null;
      print('thumbnailUrl: $thumbnailUrl');

      final res = td.querySelector('font')?.text;
      print('res: $res');

      final body = td.querySelector('small')?.text;
      print('body: $body');

      return FutabaThread(
        id: int.parse(id),
        url: threadUrl,
        thumbnailUrl: thumbnailUrl,
        count: int.parse(res),
        body: body,
      );
    }).toList();
    return CatalogParserOutput(threads, null);
  } on Exception catch (e) {
    print('[parseCatalog] Error: $e');
    return CatalogParserOutput([], CatalogParserError());
  }
}
