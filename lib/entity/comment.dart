class Comment {
  Comment({
    this.id,
    this.user,
    this.email,
    this.subject,
    this.text,
    this.thumbnailUrl,
    this.likeCount,
  });

  final String id;
  final String user;
  final String email;
  final String subject;
  final String text;
  final Uri thumbnailUrl;
  final int likeCount;
}
