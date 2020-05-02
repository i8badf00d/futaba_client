import 'package:flutter/material.dart';
import 'package:futaba_client/entity/board.dart';
import 'package:futaba_client/page/catalog/catalog_page.dart';
import 'package:futaba_client/repository/board_repository.dart';
import 'package:futaba_client/widget/board_list.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: FutureBuilder<List<Board>>(
        future: BoardRepository().fetchBoards(),
        builder: (context, snapshot) {
          return snapshot.hasData
              ? BoardList(
                  boards: snapshot.data,
                  onTap: (board) => _presentCatalogPage(context, board),
                )
              : const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  void _presentCatalogPage(BuildContext context, Board board) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(builder: (context) {
        return CatalogPage.withDependencies(board: board);
      }),
    );
  }
}
