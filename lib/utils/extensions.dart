extension StringExtension on String {
  int toInt() => int.tryParse(this);
}

extension UriExtension on Uri {
  String get lastPathComponent => toString().split('/').last;
}
