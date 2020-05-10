import 'package:futaba_client/store/store.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CatalogColumnCountStore extends Store {
  Future<int> load() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(key);
  }

  Future<void> save(int value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(key, value);
  }
}
