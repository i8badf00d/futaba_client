import 'package:futaba_client/type/catalog_sort_type.dart';

class SortMenuItem {
  SortMenuItem({this.title, this.sortType});
  final String title;
  final CatalogSortType sortType;

  static final List<SortMenuItem> allItems = [
    SortMenuItem(title: 'カタログ', sortType: CatalogSortType.none),
    SortMenuItem(title: '新順', sortType: CatalogSortType.createdDateDesc),
    SortMenuItem(title: '古順', sortType: CatalogSortType.createdDateAsc),
    SortMenuItem(title: '多順', sortType: CatalogSortType.replyCountDesc),
    SortMenuItem(title: '少順', sortType: CatalogSortType.replyCountAsc),
  ];
}
