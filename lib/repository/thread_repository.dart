import 'package:futaba_client/api/api_client.dart';
import 'package:futaba_client/entity/futaba_board.dart';
import 'package:futaba_client/entity/futaba_thread.dart';
import 'package:futaba_client/io/http.dart';
import 'package:futaba_client/type/catalog_sort_type.dart';
import 'package:http/io_client.dart';

class ThreadRepository {
  Future<List<FutabaThread>> fetchThreads(
    FutabaBoard board, {
    CatalogSortType sortType,
  }) async {
    final httpClient = IOClient(getHttpClient());
    final apiClient = ApiClient(httpClient);
    return apiClient.fetchThreads(
      board,
      sortType: sortType,
      bodyLength: 20,
    );
  }
}
