class FutabaThread {
  FutabaThread(
      {this.id, this.url, this.thumbnailUrl, this.replyCount, this.body});

  final int id;
  final Uri url;
  final Uri thumbnailUrl;
  final int replyCount;
  final String body;
}
