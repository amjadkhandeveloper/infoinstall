import 'package:flutter/foundation.dart';
import 'dart:convert';

mixin PrintMixin {
  void p(String message) {
    if (kDebugMode) {
      print(message);
    }
  }
}

const int _logBodyMaxChars =
    800; // limit to ~800 chars based on device log capacity

String _formatBodyForLog(Object? body) {
  if (body == null) return '(no body)';
  final String bodyAsString = body is String ? body : jsonEncode(body);
  if (bodyAsString.length <= _logBodyMaxChars) {
    return bodyAsString;
  }
  final int total = bodyAsString.length;
  final int headLen = (_logBodyMaxChars * 3) ~/ 4; // 75%
  final int tailLen = total > 500 ? 500 : _logBodyMaxChars - headLen; // 25%
  final String head = bodyAsString.substring(0, headLen);
  final String tail = bodyAsString.substring(total - tailLen);
  return '[truncated ${total} chars]\nHEAD:\n' + head + '\n...\nTAIL:\n' + tail;
}

/// Logs HTTP request details in debug mode only (method, URL, summarized body).
void logHttpRequest(String method, String url, {Object? body}) {
  if (!kDebugMode) return;
  print('HTTP $method → $url');
  if (body != null) {
    print('Request Body: ' + _formatBodyForLog(body));
  }
}

/// Logs HTTP response details in debug mode only (status, URL, summarized body).
void logHttpResponse(int statusCode, String url, {Object? body}) {
  if (!kDebugMode) return;
  print('HTTP ← ${statusCode} from $url');
  if (body != null) {
    print('Response Body: ' + _formatBodyForLog(body));
  }
}
