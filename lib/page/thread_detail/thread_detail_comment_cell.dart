import 'package:flutter/material.dart';
import 'package:futaba_client/entity/entity.dart';
import 'package:intl/intl.dart';

class ThreadDetailCommentCell extends StatelessWidget {
  const ThreadDetailCommentCell({Key key, this.comment, this.onLongPress})
      : super(key: key);

  final Comment comment;
  final GestureLongPressCallback onLongPress;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _buildTitle(context),
          if (comment.file != null) _buildThumbnail(context, comment.file),
          _buildText(context),
        ],
      ),
    );
  }

  Widget _buildTitle(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Text(DateFormat('yyyy/MM/dd HH:mm:ss').format(comment.postedAt)),
            const SizedBox(width: 4),
            Text('No.${comment.id}'),
            // そうだね
            if (comment.likeCount > 0) ...[
              const SizedBox(width: 4),
              Text(
                'そうだねx${comment.likeCount}',
                style: const TextStyle(color: Colors.orangeAccent),
              ),
            ]
          ],
        ),
        const SizedBox(height: 8),
      ],
    );
  }

  Widget _buildThumbnail(BuildContext context, File file) {
    final filename = file.url.lastPathComponent;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text('$filename'),
        Image.network(
          file.thumbnailUrl.toString(),
          width: file.width.toDouble(),
          height: file.height.toDouble(),
        ),
        const SizedBox(height: 8),
      ],
    );
  }

  Widget _buildText(BuildContext context) {
    return Text(comment.text);
  }
}

extension UriExtension on Uri {
  String get lastPathComponent {
    return toString().split('/').last;
  }
}
