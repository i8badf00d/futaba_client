import 'package:flutter/material.dart';
import 'package:flutter_state_notifier/flutter_state_notifier.dart';
import 'package:futaba_client/entity/thread.dart';
import 'package:futaba_client/page/thread_detail/thread_detail_comment_cell.dart';
import 'package:futaba_client/page/thread_detail/thread_detail_controller.dart';
import 'package:futaba_client/page/thread_detail/thread_detail_expires_info_cell.dart';
import 'package:futaba_client/page/thread_detail/thread_detail_row.dart';
import 'package:futaba_client/page/thread_detail/thread_detail_state.dart';
import 'package:provider/provider.dart';

class ThreadDetailPage extends StatelessWidget {
  ThreadDetailPage._({Key key}) : super(key: key);

  static Widget withDependencies({Key key, Thread thread}) {
    return StateNotifierProvider<ThreadDetailController, ThreadDetailState>(
      create: (_) => ThreadDetailController(thread),
      child: ThreadDetailPage._(key: key),
    );
  }

  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<ThreadDetailState>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(state.title ?? ''),
      ),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    final controller = Provider.of<ThreadDetailController>(context);
    final state = Provider.of<ThreadDetailState>(context);
    return RefreshIndicator(
      child: state.rows.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : Container(
              child: ListView.separated(
                itemCount: state.rows.length,
                itemBuilder: (context, index) {
                  final row = state.rows[index];
                  switch (row.type) {
                    case ThreadDetailRowType.ownerComment:
                      return ThreadDetailCommentCell(comment: row.comment);
                    case ThreadDetailRowType.reply:
                      return ThreadDetailCommentCell(comment: row.comment);
                    case ThreadDetailRowType.expiresInfo:
                      return ThreadDetailExpiresInfoCell(
                        expiresDateTime: state.expiresDateTime,
                      );
                  }
                  return const Placeholder();
                },
                separatorBuilder: (context, index) => const Divider(),
                controller: _scrollController,
              ),
            ),
      onRefresh: controller.fetch,
    );
  }
}
