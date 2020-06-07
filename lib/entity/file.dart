class File {
  File({
    this.size,
    this.url,
    this.extension,
    this.thumbnailUrl,
    this.width,
    this.height,
  });

  final int size;
  final Uri url;
  final String extension;
  final Uri thumbnailUrl;
  final int width;
  final int height;

  String get tag => url.toString();
}
