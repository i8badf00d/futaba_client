class FutabaComment {
  FutabaComment({
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

class FutabaThreadDetail {
  FutabaThreadDetail({
    this.isExpired,
    this.expirationDate,
    this.likeCountInfo,
  }) : assert(likeCountInfo != null);

  final bool isExpired;
  final DateTime expirationDate;
  final Map<String, int> likeCountInfo;
}

class FutabaThreadDetailAndReplies extends FutabaThreadDetail {
  FutabaThreadDetailAndReplies({
    bool isExpired,
    DateTime expirationDate,
    Map<String, int> likeCountInfo,
    this.replies,
  })  : assert(replies != null),
        super(
          isExpired: isExpired,
          expirationDate: expirationDate,
          likeCountInfo: likeCountInfo,
        );

  final List<FutabaComment> replies;
}
