class CatalogSortType {
  CatalogSortType._(this.value);
  final int value;

  /// 未指定
  static CatalogSortType none = CatalogSortType._(null);

  /// 新順
  static CatalogSortType createdDateDesc = CatalogSortType._(1);

  /// 古順
  static CatalogSortType createdDateAsc = CatalogSortType._(2);

  /// 多順
  static CatalogSortType replyCountDesc = CatalogSortType._(3);

  /// 少順
  static CatalogSortType replyCountAsc = CatalogSortType._(4);

  /// 勢順
  static CatalogSortType hot = CatalogSortType._(6);

  /// そ順
  static CatalogSortType likeCountDesc = CatalogSortType._(8);

  static List<CatalogSortType> allTypes = [
    CatalogSortType.none,
    CatalogSortType.createdDateDesc,
    CatalogSortType.createdDateAsc,
    CatalogSortType.replyCountDesc,
    CatalogSortType.replyCountAsc,
    CatalogSortType.hot,
    CatalogSortType.likeCountDesc,
  ];

  static CatalogSortType sortTypeForValue(int value) {
    return allTypes.firstWhere(
      (sortType) => sortType.value == value,
      orElse: () => null,
    );
  }
}
