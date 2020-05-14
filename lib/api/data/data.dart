import 'package:meta/meta.dart';

class Comment {
  Comment({
    @required this.id,
    this.username,
    this.userId,
    this.host,
    this.email,
    this.subject,
    this.text,
    this.file,
    this.postedAt,
  });

  final String id;
  final String username;
  final String userId;
  final String host;
  final String email;
  final String subject;
  final String text;
  final File file;
  final DateTime postedAt;
}

class File {
  File({
    this.size,
    this.path,
    this.extension,
    this.thumbnailPath,
    this.width,
    this.height,
  });

  final int size;
  final String path;
  final String extension;
  final String thumbnailPath;
  final int width;
  final int height;
}

class ThreadDetail {
  ThreadDetail({
    this.shouldDisplayName,
    this.shouldDisplayLikeCount,
    this.isOld,
    this.expiresDateTimeUtc,
    @required this.likeCountInfo,
  });

  final bool shouldDisplayName;
  final bool shouldDisplayLikeCount;
  final bool isOld;
  final DateTime expiresDateTimeUtc;
  final Map<String, int> likeCountInfo;
}

class ThreadDetailAndReplies extends ThreadDetail {
  ThreadDetailAndReplies({
    bool shouldDisplayName,
    bool shouldDisplayLikeCount,
    bool isOld,
    DateTime expiresDateTimeUtc,
    Map<String, int> likeCountInfo,
    @required this.replies,
  }) : super(
          shouldDisplayName: shouldDisplayName,
          shouldDisplayLikeCount: shouldDisplayLikeCount,
          isOld: isOld,
          expiresDateTimeUtc: expiresDateTimeUtc,
          likeCountInfo: likeCountInfo,
        );

  final List<Comment> replies;
}
