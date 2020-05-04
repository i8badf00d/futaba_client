import 'file.dart';

class Comment {
  Comment({
    this.id,
    this.user,
    this.userId,
    this.host,
    this.email,
    this.subject,
    this.text,
    this.file,
    this.likeCount,
  });

  final String id;
  final String user;
  final String userId;
  final String host;
  final String email;
  final String subject;
  final String text;
  final File file;
  final int likeCount;
}
