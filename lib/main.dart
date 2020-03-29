import 'package:flutter/material.dart';
import 'package:futaba_client/page/home_page.dart';
import 'package:futaba_client/store/catalog_sort_type_store.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider<CatalogSortTypeStore>(
      create: (_) => CatalogSortTypeStore(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    const appTitle = 'ふたば';
    return MaterialApp(
      title: appTitle,
      theme: ThemeData.from(colorScheme: const ColorScheme.light()),
      darkTheme: ThemeData.from(colorScheme: const ColorScheme.dark()),
      home: const HomePage(title: appTitle),
    );
  }
}
