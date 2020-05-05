import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:futaba_client/page/home/home_page.dart';
import 'package:futaba_client/store/catalog_cross_axis_count_store.dart';
import 'package:futaba_client/store/catalog_sort_type_store.dart';
import 'package:provider/provider.dart';

void main() {
  LicenseRegistry.addLicense(() async* {
    final license = await rootBundle.loadString('fonts/NotoSansJP/OFL.txt');
    yield LicenseEntryWithLineBreaks(['Noto Sans JP'], license);
  });

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<CatalogCrossAxisCountStore>(
          create: (_) => CatalogCrossAxisCountStore(),
        ),
        ChangeNotifierProvider<CatalogSortTypeStore>(
          create: (_) => CatalogSortTypeStore(),
        ),
      ],
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
      theme: ThemeData.from(colorScheme: const ColorScheme.light())
          .apply(fontFamily: 'NotoSansJP'),
      darkTheme: ThemeData.from(colorScheme: const ColorScheme.dark())
          .apply(fontFamily: 'NotoSansJP'),
      home: const HomePage(title: appTitle),
    );
  }
}

extension ThemeDataExtension on ThemeData {
  ThemeData apply({@required String fontFamily}) {
    assert(fontFamily != null);
    return copyWith(
      textTheme: textTheme.apply(fontFamily: fontFamily),
      accentTextTheme: accentTextTheme.apply(fontFamily: fontFamily),
      primaryTextTheme: primaryTextTheme.apply(fontFamily: fontFamily),
    );
  }
}
