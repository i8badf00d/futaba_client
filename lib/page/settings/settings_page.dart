import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('設定'),
      ),
      body: ListView.separated(
        itemCount: 1,
        itemBuilder: (context, index) {
          switch (index) {
            case 0:
              return ListTile(
                title: const Text('Licenses'),
                onTap: () => showLicensePage(context: context),
              );
            default:
              return null;
          }
        },
        separatorBuilder: (context, index) => const Divider(),
      ),
    );
  }
}
