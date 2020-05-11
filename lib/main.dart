import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:futaba_client/api/api.dart';
import 'package:futaba_client/io/http.dart';
import 'package:futaba_client/page/home/home_page.dart';
import 'package:futaba_client/repository/repository.dart';
import 'package:futaba_client/store/store.dart';
import 'package:http/io_client.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

void main() {
  LicenseRegistry.addLicense(() async* {
    final license = await rootBundle.loadString('fonts/NotoSansJP/OFL.txt');
    yield LicenseEntryWithLineBreaks(['Noto Sans JP'], license);
  });

  runApp(
    MultiProvider(
      providers: [
        ...repositoryProviders(),
        ...storeProviders(),
      ],
      child: MyApp(),
    ),
  );
}

List<SingleChildWidget> repositoryProviders() {
  final httpClient = IOClient(getHttpClient());
  final apiClient = ApiClient(httpClient);
  return [
    Provider(create: (_) => BoardRepository()),
    Provider(create: (_) => ThreadRepository(apiClient)),
    Provider(create: (_) => ThreadDetailRepository(apiClient)),
  ];
}

List<SingleChildWidget> storeProviders() {
  return [
    Provider(create: (_) => CatalogColumnCountStore()),
    Provider(create: (_) => CatalogSortTypeStore()),
  ];
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
