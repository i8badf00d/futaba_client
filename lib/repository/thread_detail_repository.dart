import 'package:futaba_client/api/api.dart' as api;
import 'package:futaba_client/entity/entity.dart' as entity;
import 'package:futaba_client/io/http.dart';
import 'package:http/io_client.dart';

class ThreadDetailRepository {
  Future<entity.ThreadDetail> fetchThreadDetail(entity.Thread thread) async {
    final httpClient = IOClient(getHttpClient());
    final apiClient = api.Client(httpClient);
    final ownerComment = await apiClient.fetchThreadOwnerComment(thread);
    final detailAndReplies =
        await apiClient.fetchThreadDetailAndReplies(thread);
    return _convertToThreadDetail(ownerComment, detailAndReplies);
  }

  entity.ThreadDetail _convertToThreadDetail(
    api.Comment ownerComment,
    api.ThreadDetailAndReplies detailAndReplies,
  ) {
    final likeCountInfo = detailAndReplies.likeCountInfo;
    return entity.ThreadDetail(
      ownerComment: _convertToComment(ownerComment, likeCountInfo),
      replies: detailAndReplies.replies
          .map((reply) => _convertToComment(reply, likeCountInfo))
          .toList(),
    );
  }

  entity.Comment _convertToComment(
    api.Comment comment,
    Map<String, int> likeCountInfo,
  ) {
    return entity.Comment(
      id: comment.id,
      text: comment.text,
      likeCount: likeCountInfo[comment.id] ?? 0,
    );
  }
}
