import 'package:flutter/material.dart';
import 'package:futaba_client/entity/comment.dart';
import 'package:futaba_client/entity/thread.dart';
import 'package:futaba_client/entity/thread_detail.dart';
import 'package:futaba_client/repository/thread_detail_repository.dart';

enum ThreadDetailRowType { ownerComment, reply, expiresInfo }

class ThreadDetailRow {
  ThreadDetailRow(
    this.type, {
    this.comment,
  });
  final ThreadDetailRowType type;
  final Comment comment; // for ownerComment and reply
}

class ThreadDetailPageModel with ChangeNotifier {
  ThreadDetailPageModel(this.thread) {
    update();
  }
  final Thread thread;
  List<ThreadDetailRow> rows = [];
  DateTime expiresDateTime;

  String get title => thread.body;
  ScrollController scrollController = ScrollController();

  Future<void> update() async {
    final detail = await ThreadDetailRepository().fetchThreadDetail(thread);
    if (detail == null) {
      return;
    }
    rows = _convert(detail);
    expiresDateTime = detail.expiresDateTime;
    notifyListeners();
  }

  List<ThreadDetailRow> _convert(ThreadDetail detail) {
    return []
      ..add(ThreadDetailRow(
        ThreadDetailRowType.ownerComment,
        comment: detail.ownerComment,
      ))
      ..addAll(detail.replies.map((comment) => ThreadDetailRow(
            ThreadDetailRowType.reply,
            comment: comment,
          )))
      ..add(ThreadDetailRow(ThreadDetailRowType.expiresInfo));
  }
}
