import 'package:futaba_client/store/store.dart';
import 'package:futaba_client/type/catalog_sort_type.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CatalogSortTypeStore extends Store {
  Future<CatalogSortType> load() async {
    final prefs = await SharedPreferences.getInstance();
    return CatalogSortType.sortTypeForValue(prefs.getInt(key));
  }

  Future<void> save(CatalogSortType sortType) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(key, sortType.value);
  }
}
