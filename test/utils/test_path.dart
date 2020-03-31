import 'dart:io';

String testPath(String relativePath) {
  final current = Directory.current;
  final path =
      current.path.endsWith('/test') ? current.path : '${current.path}/test';
  return '$path/$relativePath';
}
