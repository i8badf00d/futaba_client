import 'package:flutter/material.dart';
import 'package:futaba_client/entity/entity.dart';

class ThreadDetailCommentCell extends StatelessWidget {
  const ThreadDetailCommentCell({Key key, this.comment, this.onLongPress})
      : super(key: key);

  final Comment comment;
  final GestureLongPressCallback onLongPress;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _buildTitle(context),
        _buildThumbnail(context),
        _buildText(context),
      ].where((w) => w != null).toList(),
    );
  }

  Widget _buildTitle(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Text(comment.id),
            const SizedBox(width: 4),
            Text('そうだねx${comment.likeCount}'),
          ],
        ),
        const SizedBox(height: 8),
      ],
    );
  }

  Widget _buildThumbnail(BuildContext context) {
    final file = comment.file;
    if (file == null) {
      return null;
    }
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
