import 'package:flutter/material.dart';
import 'package:futaba_client/entity/futaba_board.dart';

class CatalogPage extends StatelessWidget {
  const CatalogPage({Key key, this.board}) : super(key: key);

  final FutabaBoard board;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(board.name),
      ),
      body: const Scaffold(),
    );
  }
}
