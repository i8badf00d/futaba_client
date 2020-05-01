import 'package:flutter/material.dart';
import 'package:futaba_client/entity/comment.dart';
import 'package:futaba_client/entity/thread.dart';
import 'package:futaba_client/entity/thread_detail.dart';
import 'package:futaba_client/repository/thread_detail_repository.dart';

enum ThreadDetailRowType { ownerComment, reply, bottom }

class ThreadDetailRow {
  ThreadDetailRow(
    this.type, {
    this.comment,
  });
  final ThreadDetailRowType type;
  final Comment comment;
}

class ThreadDetailPageModel with ChangeNotifier {
  ThreadDetailPageModel(this.thread) {
    update();
  }
  final Thread thread;
  List<ThreadDetailRow> rows = [];

  String get title => thread.body;
  ScrollController scrollController = ScrollController();

  Future<void> update() async {
    final detail = await ThreadDetailRepository().fetchThreadDetail(thread);
    if (detail == null) {
      return;
    }
    rows = _convert(detail);
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
      ..add(ThreadDetailRow(ThreadDetailRowType.bottom));
  }
}
