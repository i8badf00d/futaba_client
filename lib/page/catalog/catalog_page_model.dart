import 'dart:math';

import 'package:flutter/material.dart';
import 'package:futaba_client/entity/board.dart';
import 'package:futaba_client/entity/thread.dart';
import 'package:futaba_client/repository/thread_repository.dart';
import 'package:futaba_client/store/catalog_cross_axis_count_store.dart';
import 'package:futaba_client/type/catalog_sort_type.dart';

class CatalogPageModel with ChangeNotifier {
  CatalogPageModel(this.board, this.store) {
    crossAxisCount = store.value;
  }
  final Board board;
  final CatalogCrossAxisCountStore store;

  CatalogSortType sortType;
  List<Thread> threads = [];
  int crossAxisCount;

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

  int _startCrossAxisCount;

  void onScaleStart(ScaleStartDetails details) {
    _startCrossAxisCount = crossAxisCount;
  }

  void onScaleUpdate(ScaleUpdateDetails details) {
    var newCrossAxisCount =
        _startCrossAxisCount - ((details.scale - 1.0) / 0.5).round();
    newCrossAxisCount = min(6, max(2, newCrossAxisCount));
    if (crossAxisCount != newCrossAxisCount) {
      crossAxisCount = newCrossAxisCount;
      notifyListeners();
    }
  }

  void onScaleEnd(ScaleEndDetails details) {
    store.update(crossAxisCount);
  }
}
