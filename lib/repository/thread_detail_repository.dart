import 'package:futaba_client/api/api.dart' as api;
import 'package:futaba_client/entity/entity.dart' as entity;

class ThreadDetailRepository {
  ThreadDetailRepository(this.apiClient);

  final api.ApiClient apiClient;

  Future<entity.ThreadDetail> fetchThreadDetail(entity.Thread thread) async {
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
        shouldDisplayName: detailAndReplies.shouldDisplayName,
        number: 0,
      ),
      replies: detailAndReplies.replies
          .map((reply) => _convertToCommentEntity(
                reply,
                likeCountInfo,
                baseUrl,
                shouldDisplayName: detailAndReplies.shouldDisplayName,
              ))
          .toList(),
      isOld: detailAndReplies.isOld,
      isDead: ownerComment == null,
      expiresDateTime: detailAndReplies.expiresDateTimeUtc.toLocal(),
    );
  }

  entity.Comment _convertToCommentEntity(
    api.Comment comment,
    Map<String, int> likeCountInfo,
    Uri baseUrl, {
    bool shouldDisplayName,
    int number,
  }) {
    if (comment == null) {
      return null;
    }
    return entity.Comment(
      id: comment.id,
      number: number ?? comment.number,
      username: shouldDisplayName ? comment.username : '',
      userId: comment.userId,
      host: comment.host,
      email: comment.email,
      subject: shouldDisplayName ? comment.subject : '',
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
