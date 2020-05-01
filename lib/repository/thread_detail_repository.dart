import 'package:futaba_client/api/api_client.dart';
import 'package:futaba_client/api/response/response.dart';
import 'package:futaba_client/entity/comment.dart';
import 'package:futaba_client/entity/thread.dart';
import 'package:futaba_client/entity/thread_detail.dart';
import 'package:futaba_client/io/http.dart';
import 'package:http/io_client.dart';

class ThreadDetailRepository {
  Future<ThreadDetail> fetchThreadDetail(Thread thread) async {
    final httpClient = IOClient(getHttpClient());
    final apiClient = ApiClient(httpClient);
    final ownerComment = await apiClient.fetchThreadOwnerComment(thread);
    final detailAndReplies =
        await apiClient.fetchThreadDetailAndReplies(thread);
    return _convertToThreadDetail(ownerComment, detailAndReplies);
  }

  ThreadDetail _convertToThreadDetail(
    FutabaComment ownerComment,
    FutabaThreadDetailAndReplies detailAndReplies,
  ) {
    final likeCountInfo = detailAndReplies.likeCountInfo;
    return ThreadDetail(
      ownerComment: _convertToComment(ownerComment, likeCountInfo),
      replies: detailAndReplies.replies
          .map((reply) => _convertToComment(reply, likeCountInfo))
          .toList(),
    );
  }

  Comment _convertToComment(
    FutabaComment comment,
    Map<String, int> likeCountInfo,
  ) {
    return Comment(
      id: comment.id,
      text: comment.text,
      likeCount: likeCountInfo[comment.id] ?? 0,
    );
  }
}
