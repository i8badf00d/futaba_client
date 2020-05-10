import 'package:futaba_client/store/store.dart';

class PreferencesKey {
  static const _catalogColumnCount = 'catalog_column_count';
  static const _catalogSortType = 'catalog_sort_type';

  static String keyForStore(Store store) {
    switch (store.runtimeType) {
      case CatalogColumnCountStore:
        return _catalogColumnCount;
      case CatalogSortTypeStore:
        return _catalogSortType;
    }
    assert(false, '${store.runtimeType} の PreferencesKey が未定義です。');
    return null;
  }
}
