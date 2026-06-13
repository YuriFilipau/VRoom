import 'dart:convert';

import 'package:dio/dio.dart';

String? utf8ResponseDecoder(
  List<int> responseBytes,
  RequestOptions options,
  ResponseBody responseBody,
) {
  if (responseBytes.isEmpty) {
    return null;
  }
  return utf8.decode(responseBytes, allowMalformed: true);
}
