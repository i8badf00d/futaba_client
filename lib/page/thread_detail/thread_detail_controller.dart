import 'package:futaba_client/entity/thread.dart';
import 'package:futaba_client/entity/thread_detail.dart';
import 'package:futaba_client/page/thread_detail/thread_detail_row.dart';
import 'package:futaba_client/page/thread_detail/thread_detail_state.dart';
import 'package:futaba_client/repository/thread_detail_repository.dart';
import 'package:state_notifier/state_notifier.dart';

class ThreadDetailController extends StateNotifier<ThreadDetailState>
    with LocatorMixin {
  ThreadDetailController(this.thread)
      : super(ThreadDetailState(
          title: thread.body,
          rows: [],
        ));

  final Thread thread;

  @override
  void initState() {
    fetch();
  }

  Future<void> fetch() async {
    final detail = await ThreadDetailRepository().fetchThreadDetail(thread);
    if (detail == null) {
      return;
    }
    state = state.copyWith(
      title: detail.ownerComment.text.split('\n').first,
      rows: _convert(detail),
      expiresDateTime: detail.expiresDateTime,
    );
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
