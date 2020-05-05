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
    return _convertToThreadDetailEntity(
      ownerComment,
      detailAndReplies,
      thread.url,
    );
  }

  entity.ThreadDetail _convertToThreadDetailEntity(
    api.Comment ownerComment,
    api.ThreadDetailAndReplies detailAndReplies,
    Uri baseUrl,
  ) {
    final likeCountInfo = detailAndReplies.likeCountInfo;
    return entity.ThreadDetail(
      ownerComment: _convertToCommentEntity(
        ownerComment,
        likeCountInfo,
        baseUrl,
      ),
      replies: detailAndReplies.replies
          .map((reply) => _convertToCommentEntity(
                reply,
                likeCountInfo,
                baseUrl,
              ))
          .toList(),
    );
  }

  entity.Comment _convertToCommentEntity(
    api.Comment comment,
    Map<String, int> likeCountInfo,
    Uri baseUrl,
  ) {
    if (comment == null) {
      return null;
    }
    return entity.Comment(
      id: comment.id,
      username: comment.username,
      userId: comment.userId,
      host: comment.host,
      email: comment.email,
      subject: comment.subject,
      text: comment.text ?? '',
      file: _convertToFileEntity(comment.file, baseUrl),
      postedAt: comment.postedAt,
      likeCount: likeCountInfo[comment.id] ?? 0,
    );
  }

  entity.File _convertToFileEntity(
    api.File file,
    Uri baseUrl,
  ) {
    if (file == null) {
      return null;
    }
    return entity.File(
      size: file.size,
      url: baseUrl.resolve(file.path),
      extension: file.extension,
      thumbnailUrl: baseUrl.resolve(file.thumbnailPath),
      width: file.width,
      height: file.height,
    );
  }
}
