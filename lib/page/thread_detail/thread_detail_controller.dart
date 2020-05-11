import 'package:futaba_client/entity/thread.dart';
import 'package:futaba_client/entity/thread_detail.dart';
import 'package:futaba_client/page/thread_detail/thread_detail_row.dart';
import 'package:futaba_client/page/thread_detail/thread_detail_state.dart';
import 'package:futaba_client/repository/thread_detail_repository.dart';
import 'package:state_notifier/state_notifier.dart';

class ThreadDetailController extends StateNotifier<ThreadDetailState>
    with LocatorMixin {
  ThreadDetailController(this.thread)
      : super(ThreadDetailState(title: '', rows: []));

  final Thread thread;

  ThreadDetailRepository get threadDetailRepository =>
      read<ThreadDetailRepository>();

  @override
  void initState() {
    fetch();
  }

  Future<void> fetch() async {
    final detail = await threadDetailRepository.fetchThreadDetail(thread);
    if (detail == null) {
      return;
    }
    state = state.copyWith(
      title: detail.ownerComment != null
          ? detail.ownerComment.text.split('\n').first
          : thread.body,
      rows: _convert(detail),
      expiresDateTime: detail.isExpired ? null : detail.expiresDateTime,
      errorMessage: detail.isExpired ? 'スレは落ちました' : null,
    );
  }

  List<ThreadDetailRow> _convert(ThreadDetail detail) {
    return [
      if (detail.ownerComment != null)
        ThreadDetailRow(
          ThreadDetailRowType.ownerComment,
          comment: detail.ownerComment,
        ),
      ...detail.replies.map((comment) => ThreadDetailRow(
            ThreadDetailRowType.reply,
            comment: comment,
          )),
      ThreadDetailRow(ThreadDetailRowType.expiresInfo),
    ];
  }
}
