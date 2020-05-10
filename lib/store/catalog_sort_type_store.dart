import 'package:futaba_client/type/catalog_sort_type.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CatalogSortTypeStore {
  final _key = 'catalog_sort_type';

  Future<CatalogSortType> load() async {
    final prefs = await SharedPreferences.getInstance();
    return CatalogSortType.sortTypeForValue(prefs.getInt(_key));
  }

  Future<void> save(CatalogSortType sortType) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_key, sortType.value);
  }
}
