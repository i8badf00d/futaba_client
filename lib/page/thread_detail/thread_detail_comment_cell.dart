import 'package:extended_image/extended_image.dart';
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
        Hero(
          tag: file.url.toString(),
          child: GestureDetector(
            child: ExtendedImage.network(
              file.thumbnailUrl.toString(),
              width: file.width.toDouble(),
              height: file.height.toDouble(),
            ),
            onTap: () => Navigator.of(context).push<void>(
              TransparentMaterialPageRoute(
                builder: (context) => ImageDetailPage(
                  file: file,
                ),
              ),
            ),
          ),
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

class ImageDetailPage extends StatelessWidget {
  const ImageDetailPage({
    Key key,
    @required this.file,
  }) : super(key: key);

  final File file;

  @override
  Widget build(BuildContext context) {
    return ExtendedImageSlidePage(
      child: GestureDetector(
        onTap: () => Navigator.of(context).pop(),
        child: ExtendedImage.network(
          file.url.toString(),
          fit: BoxFit.contain,
          enableSlideOutPage: true,
          mode: ExtendedImageMode.gesture,
          loadStateChanged: (state) {
            switch (state.extendedImageLoadState) {
              case LoadState.loading:
                break;
              case LoadState.failed:
                return Icon(Icons.broken_image);
              case LoadState.completed:
                break;
            }
            return null;
          },
          heroBuilderForSlidingPage: (image) => Hero(
            tag: file.url.toString(),
            child: image,
            flightShuttleBuilder: (
              flightContext,
              animation,
              flightDirection,
              fromHeroContext,
              toHeroContext,
            ) {
              final hero = (flightDirection == HeroFlightDirection.pop
                  ? fromHeroContext.widget
                  : toHeroContext.widget) as Hero;
              return hero.child;
            },
          ),
        ),
      ),
    );
  }
}
