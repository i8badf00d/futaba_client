class Thread {
  Thread({
    this.id,
    this.url,
    this.thumbnailUrl,
    this.replyCount,
    this.body,
  });

  final String id;
  final Uri url;
  final Uri thumbnailUrl;
  final int replyCount;
  final String body;
}
