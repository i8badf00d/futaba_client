class Comment {
  Comment({
    this.id,
    this.username,
    this.email,
    this.subject,
    this.text,
    this.thumbnailUrl,
  }) : assert(id != null);

  final String id;
  final String username;
  final String email;
  final String subject;
  final String text;
  final Uri thumbnailUrl;
}

class ThreadDetail {
  ThreadDetail({
    this.isExpired,
    this.expirationDateTimeUtc,
    this.likeCountInfo,
  }) : assert(likeCountInfo != null);

  final bool isExpired;
  final DateTime expirationDateTimeUtc;
  final Map<String, int> likeCountInfo;
}

class ThreadDetailAndReplies extends ThreadDetail {
  ThreadDetailAndReplies({
    bool isExpired,
    DateTime expirationDateTimeUtc,
    Map<String, int> likeCountInfo,
    this.replies,
  })  : assert(replies != null),
        super(
          isExpired: isExpired,
          expirationDateTimeUtc: expirationDateTimeUtc,
          likeCountInfo: likeCountInfo,
        );

  final List<Comment> replies;
}
