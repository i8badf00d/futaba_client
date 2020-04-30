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

final RegExp _digitRegExp = RegExp(r'(\d+)');

CatalogParserOutput parseCatalog(CatalogParserInput input) {
  try {
    final doc = Document.html(input.responseBody);
    final tds = doc.querySelector('#cattable')?.querySelectorAll('td');
    if (tds == null) {
      return CatalogParserOutput([], CatalogParserError());
    }
    final threads = tds
        .map<FutabaThread>((td) {
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
          final anchorElement = td.querySelector('a');
          if (anchorElement == null) {
            return null;
          }
          final href = anchorElement.attributes['href'];
          if (href == null) {
            return null;
          }
          final threadUrl = input.baseUrl.resolve(href);
          final idMatch = _digitRegExp.firstMatch(href);
          if (idMatch.groupCount != 1) {
            return null;
          }
          final id = idMatch.group(idMatch.groupCount - 1);

          final imageElement = td.querySelector('img');
          final thumbnailUrl =
              imageElement != null && imageElement.attributes['src'] != null
                  ? input.baseUrl.resolve(imageElement.attributes['src'])
                  : null;

          final count = td.querySelector('font')?.text?.trim() ?? '';

          final body = td.querySelector('small')?.text?.trim();

          return FutabaThread(
            id: int.parse(id),
            url: threadUrl,
            thumbnailUrl: thumbnailUrl,
            replyCount: int.tryParse(count),
            body: body,
          );
        })
        .where((x) => x != null)
        .toList();
    return CatalogParserOutput(threads, null);
  } on Exception catch (e) {
    print('[CatalogParser] Error: $e');
    return CatalogParserOutput([], CatalogParserError());
  }
}
