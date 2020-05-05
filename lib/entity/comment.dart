import 'file.dart';

class Comment {
  Comment({
    this.id,
    this.username,
    this.userId,
    this.host,
    this.email,
    this.subject,
    this.text,
    this.file,
    this.postedAt,
    this.likeCount,
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
  final int likeCount;
}
