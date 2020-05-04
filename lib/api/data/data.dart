class Comment {
  Comment({
    this.id,
    this.username,
    this.userId,
    this.host,
    this.email,
    this.subject,
    this.text,
    this.thumbnailUrl,
  }) : assert(id != null);

  final String id;
  final String username;
  final String userId;
  final String host;
  final String email;
  final String subject;
  final String text;
  final Uri thumbnailUrl;
}

class ThreadDetail {
  ThreadDetail({
    this.isExpired,
    this.expiresDateTimeUtc,
    this.likeCountInfo,
  }) : assert(likeCountInfo != null);

  final bool isExpired;
  final DateTime expiresDateTimeUtc;
  final Map<String, int> likeCountInfo;
}

class ThreadDetailAndReplies extends ThreadDetail {
  ThreadDetailAndReplies({
    bool isExpired,
    DateTime expiresDateTimeUtc,
    Map<String, int> likeCountInfo,
    this.replies,
  })  : assert(replies != null),
        super(
          isExpired: isExpired,
          expiresDateTimeUtc: expiresDateTimeUtc,
          likeCountInfo: likeCountInfo,
        );

  final List<Comment> replies;
}
