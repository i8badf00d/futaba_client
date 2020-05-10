import 'package:futaba_client/entity/comment.dart';

enum ThreadDetailRowType { ownerComment, reply, expiresInfo }

class ThreadDetailRow {
  ThreadDetailRow(
    this.type, {
    this.comment,
  });

  final ThreadDetailRowType type;
  final Comment comment; // for ownerComment and reply
}
