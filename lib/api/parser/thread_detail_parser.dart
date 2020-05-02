import 'dart:convert';

import 'package:futaba_client/api/response/response.dart';
import 'package:futaba_client/utils/safe_cast.dart';

FutabaThreadDetail parseThreadDetail(String responseBody) {
  final json = _jsonDecode(responseBody);

  return FutabaThreadDetail(
    isExpired: _parseIsExpired(json),
    expirationDate: _parseExpirationDate(json),
    likeCountInfo: _parseLikeCountInfo(json),
  );
}

FutabaThreadDetailAndReplies parseThreadDetailAndReplies(String responseBody) {
  final json = _jsonDecode(responseBody);

  return FutabaThreadDetailAndReplies(
    isExpired: _parseIsExpired(json),
    expirationDate: _parseExpirationDate(json),
    likeCountInfo: _parseLikeCountInfo(json),
    replies: _parseComments(json),
  );
}

List<FutabaComment> parseComments(String responseBody) {
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

/// `.old` をパースします。
bool _parseIsExpired(Map<String, dynamic> json) {
  return safeCast<int>(json['old'], onFailure: 0) != 0;
}

/// `.dielong` をパースします。
DateTime _parseExpirationDate(Map<String, dynamic> json) {
  // TODO: expirationDate のパース
  //       e.g. "Thu, 30 Apr 2020 19:09:39 GMT"
  // final expirationDateString = safeCast<String>(json['dielong']);
  return null;
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
List<FutabaComment> _parseComments(Map<String, dynamic> json) {
  final info = safeCast<Map<String, dynamic>>(json['res']);
  if (info == null) {
    print('[parseComments] failed to cast: ${json['res']}');
    return [];
  }
  return info.entries.map(_parseComment).toList();
}

FutabaComment _parseComment(MapEntry<String, dynamic> entry) {
  return FutabaComment(
    id: entry.key,
    username: entry.value['name'] as String,
    email: entry.value['email'] as String,
    subject: entry.value['sub'] as String,
    text: entry.value['com'] as String,
  );
}
