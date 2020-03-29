import 'package:flutter/material.dart';
import 'package:futaba_client/entity/futaba_board.dart';

typedef BoardListTapCallback = void Function(FutabaBoard board);

class BoardList extends StatelessWidget {
  const BoardList({Key key, this.boards, this.onTap}) : super(key: key);

  final List<FutabaBoard> boards;
  final BoardListTapCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: boards.length,
      itemBuilder: (context, index) {
        final board = boards[index];
        return ListTile(
          leading: Icon(Icons.book),
          title: Text(board.name),
          subtitle: Text(board.baseUrl.toString()),
          onTap: () => onTap?.call(board),
        );
      },
    );
  }
}
