import 'package:flutter/material.dart';
import 'package:futaba_client/entity/thread.dart';
import 'package:futaba_client/page/thread_detail/thread_detail_comment_cell.dart';
import 'package:futaba_client/page/thread_detail/thread_detail_page_model.dart';
import 'package:provider/provider.dart';

class ThreadDetailPage extends StatelessWidget {
  const ThreadDetailPage._({Key key}) : super(key: key);

  static Widget withDependencies({Key key, Thread thread}) {
    return ChangeNotifierProvider<ThreadDetailPageModel>(
      create: (_) => ThreadDetailPageModel(thread),
      child: ThreadDetailPage._(key: key),
    );
  }

  @override
  Widget build(BuildContext context) {
    final pageModel = Provider.of<ThreadDetailPageModel>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(pageModel.title),
      ),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    final pageModel = Provider.of<ThreadDetailPageModel>(context);
    return RefreshIndicator(
      child: pageModel.rows.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : Container(
              child: ListView.separated(
                itemCount: pageModel.rows.length,
                itemBuilder: (context, index) {
                  final row = pageModel.rows[index];
                  switch (row.type) {
                    case ThreadDetailRowType.ownerComment:
                      return ThreadDetailCommentCell(comment: row.comment);
                    case ThreadDetailRowType.reply:
                      return ThreadDetailCommentCell(comment: row.comment);
                    case ThreadDetailRowType.bottom:
                      break;
                  }
                  return const Placeholder();
                },
                separatorBuilder: (context, index) => const Divider(),
                controller: pageModel.scrollController,
              ),
            ),
      onRefresh: pageModel.update,
    );
  }
}
