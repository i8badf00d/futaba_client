import 'package:futaba_client/store/preferences_key.dart';

export './catalog_column_count_store.dart';
export './catalog_sort_type_store.dart';

abstract class Store {
  String get key => PreferencesKey.keyForStore(this);
}
