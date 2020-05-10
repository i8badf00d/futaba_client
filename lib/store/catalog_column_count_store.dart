import 'package:shared_preferences/shared_preferences.dart';

class CatalogColumnCountStore {
  final _key = 'catalog_column_count';

  Future<int> load() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_key);
  }

  Future<void> save(int value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_key, value);
  }
}
