import 'dart:math';

import 'package:flutter/material.dart';
import 'package:futaba_client/entity/board.dart';
import 'package:futaba_client/page/catalog/catalog_state.dart';
import 'package:futaba_client/repository/thread_repository.dart';
import 'package:futaba_client/store/catalog_column_count_store.dart';
import 'package:futaba_client/store/catalog_sort_type_store.dart';
import 'package:futaba_client/type/catalog_sort_type.dart';
import 'package:state_notifier/state_notifier.dart';

class CatalogController extends StateNotifier<CatalogState> with LocatorMixin {
  CatalogController(this.board) : super(CatalogState(threads: []));

  final Board board;

  CatalogSortTypeStore get sortTypeStore => read<CatalogSortTypeStore>();
  CatalogColumnCountStore get columnCountStore =>
      read<CatalogColumnCountStore>();

  @override
  void initState() {
    print('[CatalogController] initState');
    _initialLoad();
  }

  @override
  void dispose() {
    print('[CatalogController] dispose');
    super.dispose();
  }

  Future<void> _initialLoad() async {
    final sortType = await sortTypeStore.load();
    final columnCount = await columnCountStore.load() ?? 4;
    state = state.copyWith(
      sortType: sortType,
      columnCount: columnCount,
    );
    return fetchThreads();
  }

  Future<void> fetchThreads() async {
    print('[CatalogController] fetchThreads');
    final threads = await ThreadRepository().fetchThreads(
      board,
      sortType: state.sortType,
    );
    state = state.copyWith(threads: threads);
  }

  void selectSortType(CatalogSortType sortType) {
    print('[CatalogController] selectSortType');
    if (state.sortType != sortType) {
      state = state.copyWith(sortType: sortType);
      fetchThreads();
    }
    sortTypeStore.save(sortType);
  }

  int _currentColumnCount;

  void onScaleStart(ScaleStartDetails details) {
    _currentColumnCount = state.columnCount;
  }

  void onScaleUpdate(ScaleUpdateDetails details) {
    var newColumnCount =
        _currentColumnCount - ((details.scale - 1.0) / 0.5).round();
    newColumnCount = max(2, min(6, newColumnCount));
    if (state.columnCount != newColumnCount) {
      state = state.copyWith(columnCount: newColumnCount);
    }
  }

  void onScaleEnd(ScaleEndDetails details) {
    columnCountStore.save(state.columnCount);
  }
}
