import 'package:flutter/material.dart';

class CatalogCrossAxisCountStore with ChangeNotifier {
  int value = 4;

  void update(int newValue) {
    value = newValue;
    notifyListeners();
  }
}
