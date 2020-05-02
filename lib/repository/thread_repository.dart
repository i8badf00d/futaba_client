import 'package:futaba_client/api/api.dart' as api;
import 'package:futaba_client/entity/board.dart';
import 'package:futaba_client/entity/thread.dart';
import 'package:futaba_client/io/http.dart';
import 'package:futaba_client/type/catalog_sort_type.dart';
import 'package:http/io_client.dart';

class ThreadRepository {
  Future<List<Thread>> fetchThreads(
    Board board, {
    CatalogSortType sortType,
  }) async {
    final httpClient = IOClient(getHttpClient());
    final apiClient = api.Client(httpClient);
    return apiClient.fetchThreads(
      board,
      sortType: sortType,
      bodyLength: 20,
    );
  }
}
