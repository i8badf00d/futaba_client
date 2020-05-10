import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:futaba_client/entity/thread.dart';
import 'package:futaba_client/type/catalog_sort_type.dart';

part 'catalog_state.freezed.dart';

@freezed
abstract class CatalogState with _$CatalogState {
  factory CatalogState({
    CatalogSortType sortType,
    int columnCount,
    List<Thread> threads,
  }) = _CatalogState;
}
