import 'package:flutter/material.dart';
import 'package:futaba_client/entity/futaba_board.dart';
import 'package:futaba_client/entity/futaba_thread.dart';
import 'package:futaba_client/repository/thread_repository.dart';
import 'package:futaba_client/type/catalog_sort_type.dart';

class CatalogPageModel with ChangeNotifier {
  CatalogPageModel(this.board);
  final FutabaBoard board;
  CatalogSortType sortType;
  List<FutabaThread> threads = [];

  ScrollController scrollController = ScrollController();

  void selectSortType(CatalogSortType sortType) {
    if (this.sortType != sortType) {
      this.sortType = sortType;
      fetchThreads();
    }
  }

  Future<void> fetchThreads() async {
    threads = await ThreadRepository().fetchThreads(
      board,
      sortType: sortType,
    );
    notifyListeners();
  }
}
