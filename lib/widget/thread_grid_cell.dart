import 'package:flutter/material.dart';
import 'package:futaba_client/entity/thread.dart';

class ThreadGridCell extends StatelessWidget {
  const ThreadGridCell({Key key, this.thread, this.onTap}) : super(key: key);

  final Thread thread;
  final GestureTapCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // サムネイル画像
        SizedBox.expand(
          child: thread.thumbnailUrl != null
              ? Image.network(
                  thread.thumbnailUrl.toString(),
                )
              : const Icon(Icons.broken_image),
        ),
        // レス数
        SizedBox(
          child: Container(
            padding: const EdgeInsets.all(2),
            color: Colors.black54,
            child: Text(
              '${thread.replyCount}',
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ),
        // 本文
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          child: SizedBox(
            child: Container(
              padding: const EdgeInsets.only(left: 2, right: 2),
              color: Colors.black54,
              child: Text(
                '${thread.body}',
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ),
        ),
        Material(
          type: MaterialType.transparency,
          child: InkWell(onTap: () => onTap?.call()),
        ),
      ],
    );
  }
}
