import 'dart:convert';

import 'package:futaba_client/api/data/data.dart';
import 'package:futaba_client/utils/safe_cast.dart';
import 'package:html/dom.dart' as dom;
import 'package:html/dom_parsing.dart';
import 'package:intl/intl.dart';

ThreadDetail parseThreadDetail(String responseBody) {
  final json = _jsonDecode(responseBody);

  return ThreadDetail(
    shouldDisplayName: _parseShouldDisplayName(json),
    shouldDisplayLikeCount: _parseShouldDisplayLikeCount(json),
    isOld: _parseIsOld(json),
    expiresDateTimeUtc: _parseExpiresDateTimeUtc(json),
    likeCountInfo: _parseLikeCountInfo(json),
  );
}

ThreadDetailAndReplies parseThreadDetailAndReplies(String responseBody) {
  final json = _jsonDecode(responseBody);

  return ThreadDetailAndReplies(
    shouldDisplayName: _parseShouldDisplayName(json),
    shouldDisplayLikeCount: _parseShouldDisplayLikeCount(json),
    isOld: _parseIsOld(json),
    expiresDateTimeUtc: _parseExpiresDateTimeUtc(json),
    likeCountInfo: _parseLikeCountInfo(json),
    replies: _parseComments(json),
  );
}

List<Comment> parseComments(String responseBody) {
  final json = _jsonDecode(responseBody);
  return _parseComments(json);
}

// Util

int intValue(dynamic object, {int defaultValue = 0}) {
  if (object is int) {
    return object;
  }
  if (object is String) {
    return int.tryParse(object) ?? defaultValue;
  }
  return defaultValue;
}

// Private methods

Map<String, dynamic> _jsonDecode(String responseBody) {
  return safeCast<Map<String, dynamic>>(
    jsonDecode(responseBody),
    onFailure: <String, dynamic>{},
  );
}

/// `.dispname` をパースします。
bool _parseShouldDisplayName(Map<String, dynamic> json) {
  return intValue(json['dispname']) == 1;
}

/// `.dispsod` をパースします。
bool _parseShouldDisplayLikeCount(Map<String, dynamic> json) {
  return intValue(json['dispsod']) == 1;
}

/// `.old` をパースします。
bool _parseIsOld(Map<String, dynamic> json) {
  return intValue(json['old']) == 1;
}

/// `.dielong` をパースします。
DateTime _parseExpiresDateTimeUtc(Map<String, dynamic> json) {
  final dielong = safeCast<String>(json['dielong']);
  if (dielong == null) {
    return null;
  }
  // e.g. `"Mon, 04 May 2020 06:21:34 GMT"`
  return DateFormat('EEE, d MMM yyyy HH:mm:ss').parseUtc(dielong);
}

/// `.sd` をパースします。
Map<String, int> _parseLikeCountInfo(Map<String, dynamic> json) {
  final info = safeCast<Map<String, dynamic>>(json['sd']);
  if (info == null) {
    print('[parseLikeCountInfo] failed to cast: ${json['sd']}');
    return <String, int>{};
  }
  return Map.fromEntries(
      info.entries.map((e) => MapEntry(e.key, intValue(e.value))));
}

/// `.res[]` をパースします。
List<Comment> _parseComments(Map<String, dynamic> json) {
  final info = safeCast<Map<String, dynamic>>(json['res']);
  if (info == null) {
    print('[parseComments] failed to cast: ${json['res']}');
    return [];
  }
  return info.entries.map(_parseComment).toList();
}

Comment _parseComment(MapEntry<String, dynamic> entry) {
  final text = entry.value['com'] as String;
  final node = dom.Element.html('<div>$text</div>');

  return Comment(
    id: entry.key,
    number: entry.value['rsc'] as int,
    username: entry.value['name'] as String,
    userId: entry.value['id'] as String,
    host: entry.value['host'] as String,
    email: entry.value['email'] as String,
    subject: entry.value['sub'] as String,
    text: _getText(node),
    file: _parseFile(entry),
    postedAt: DateTime.fromMillisecondsSinceEpoch(intValue(entry.value['tim'])),
  );
}

String _getText(dom.Node node) => (TextVisitor()..visit(node)).toString();

class TextVisitor extends TreeVisitor {
  final _sb = StringBuffer();

  @override
  String toString() => _sb.toString();

  @override
  void visitText(dom.Text node) {
    _sb.write(node.data);
  }

  @override
  void visitElement(dom.Element node) {
    if (node.localName == 'br') {
      _sb.write('\n');
    }
    super.visitElement(node);
  }
}

File _parseFile(MapEntry<String, dynamic> entry) {
  final fileSize = safeCast<int>(entry.value['fsize'], onFailure: 0);
  if (fileSize > 0) {
    return File(
      size: fileSize,
      path: entry.value['src'] as String,
      extension: entry.value['ext'] as String,
      thumbnailPath: entry.value['thumb'] as String,
      width: entry.value['w'] as int,
      height: entry.value['h'] as int,
    );
  }
  return null;
}
