import 'package:flutter/material.dart';
import 'package:futaba_client/entity/board.dart';

typedef BoardListTapCallback = void Function(Board board);

class BoardList extends StatelessWidget {
  const BoardList({Key key, this.boards, this.onTap}) : super(key: key);

  final List<Board> boards;
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
