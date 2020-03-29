import 'package:flutter/material.dart';
import 'package:futaba_client/type/catalog_sort_type.dart';

class CatalogSortTypeStore with ChangeNotifier {
  CatalogSortType value = CatalogSortType.none;

  void selectSortType(CatalogSortType newValue) {
    value = newValue;
    notifyListeners();
  }
}
