import 'dart:async';

import 'package:euc/jis.dart';
import 'package:flutter/foundation.dart';
import 'package:futaba_client/api/parser/catalog_parser.dart';
import 'package:futaba_client/entity/futaba_board.dart';
import 'package:futaba_client/entity/futaba_thread.dart';
import 'package:futaba_client/type/catalog_sort_type.dart';
import 'package:http/http.dart' as http;

class ApiClient {
  ApiClient(this.client);
  final http.Client client;

  /// カタログからスレッド一覧を取得します。
  Future<List<FutabaThread>> fetchThreads(
    FutabaBoard board, {
    CatalogSortType sortType,
    int numberOfThreads = 120,
    int bodyLength = 4,
  }) async {
    final queryParameters = {'mode': 'cat'};
    if (sortType != null && sortType.value != null) {
      queryParameters['sort'] = '${sortType.value}';
    }
    final catalogUrl = board.baseUrl
        .resolve('futaba.php')
        .replace(queryParameters: queryParameters);
    final response = await client.get(
      catalogUrl,
      headers: {'cookie': 'cxyl=${numberOfThreads}x1x${bodyLength}x0x1'},
    );
    final responseBody = ShiftJIS().decode(response.bodyBytes);

    // Use the compute function to run parseCatalog in a separate isolate.
    final input = CatalogParserInput(board.baseUrl, responseBody);
    final output = await compute(parseCatalog, input);
    return output.threads;
  }
}
