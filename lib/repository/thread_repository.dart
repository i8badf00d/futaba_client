import 'package:futaba_client/api/api.dart';
import 'package:futaba_client/entity/board.dart';
import 'package:futaba_client/entity/thread.dart';
import 'package:futaba_client/type/catalog_sort_type.dart';

class ThreadRepository {
  ThreadRepository(this.apiClient);

  final ApiClient apiClient;

  Future<List<Thread>> fetchThreads(
    Board board, {
    CatalogSortType sortType,
  }) async {
    return apiClient.fetchThreads(
      board,
      sortType: sortType,
      bodyLength: 20,
    );
  }
}
