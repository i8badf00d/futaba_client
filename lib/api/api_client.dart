import 'dart:async';

import 'package:euc/jis.dart';
import 'package:flutter/foundation.dart';
import 'package:futaba_client/api/parser/catalog_parser.dart';
import 'package:futaba_client/api/parser/thread_detail_parser.dart';
import 'package:futaba_client/api/response/response.dart';
import 'package:futaba_client/entity/board.dart';
import 'package:futaba_client/entity/thread.dart';
import 'package:futaba_client/type/catalog_sort_type.dart';
import 'package:http/http.dart' as http;

class ApiClient {
  ApiClient(this.client);
  final http.Client client;

  /// カタログからスレッド一覧を取得します。
  Future<List<Thread>> fetchThreads(
    Board board, {
    CatalogSortType sortType,
    int numberOfThreads = 240,
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

  /// スレッド主のコメントを取得します。
  Future<FutabaComment> fetchThreadOwnerComment(Thread thread) async {
    final queryParameters = {
      'mode': 'json',
      'start': '${thread.id}',
      'end': '${thread.id}',
    };
    final url = thread.url
        .resolve('../futaba.php')
        .replace(queryParameters: queryParameters);
    final response = await client.get(url);
    final comments = parseComments(response.body);
    return comments.firstWhere((c) => c.id == thread.id, orElse: () => null);
  }

  /// スレッド詳細を取得します。
  Future<FutabaThreadDetail> fetchThreadDetail(Thread thread) async {
    final queryParameters = {
      'mode': 'json',
      'res': '${thread.id}',
      'end': '${thread.id}',
    };
    final url = thread.url
        .resolve('../futaba.php')
        .replace(queryParameters: queryParameters);
    final response = await client.get(url);
    return parseThreadDetail(response.body);
  }

  /// スレッド詳細および返信を取得します。
  Future<FutabaThreadDetailAndReplies> fetchThreadDetailAndReplies(
    Thread thread, {
    String start,
  }) async {
    final queryParameters = {
      'mode': 'json',
      'res': '${thread.id}',
    };
    if (start != null && start.isNotEmpty) {
      queryParameters['start'] = start;
    }
    final url = thread.url
        .resolve('../futaba.php')
        .replace(queryParameters: queryParameters);
    final response = await client.get(url);
    return parseThreadDetailAndReplies(response.body);
  }
}
