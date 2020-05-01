import 'package:flutter/material.dart';
import 'package:futaba_client/entity/board.dart';
import 'package:futaba_client/entity/thread.dart';
import 'package:futaba_client/repository/thread_repository.dart';
import 'package:futaba_client/type/catalog_sort_type.dart';

class CatalogPageModel with ChangeNotifier {
  CatalogPageModel(this.board);
  final Board board;
  CatalogSortType sortType;
  List<Thread> threads = [];

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
