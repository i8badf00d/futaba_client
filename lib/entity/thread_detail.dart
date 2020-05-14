import 'package:futaba_client/entity/comment.dart';

class ThreadDetail {
  ThreadDetail({
    this.id,
    this.url,
    this.ownerComment,
    this.replies,
    this.isOld,
    this.isDead,
    this.expiresDateTime,
  });

  final int id;
  final Uri url;
  final Comment ownerComment;
  final List<Comment> replies;
  final bool isOld;
  final bool isDead;
  final DateTime expiresDateTime;
}
