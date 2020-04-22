import 'dart:convert';

import 'package:http/http.dart' as http;

import 'postmon_cep_info.dart';

enum ErrorType { invalidCepFormat, nonExistentCep }
enum PostmonReturnType { json, xml }

class PostmonSearchCep {
  static const String BASE_URL = 'https://api.postmon.com.br/v1/cep';
  static const int OK = 200;
  static const int BAD_REQUEST = 404;

  static Future<PostmonCepInfo> searchInfoByCep(
      {String cep,
      PostmonReturnType returnType = PostmonReturnType.json}) async {
    try {
      final response = await http.get(
          '$BASE_URL/$cep${returnType == PostmonReturnType.xml ? '?format=xml' : ''}');

      if (response.statusCode == OK) {
        switch (returnType) {
          case PostmonReturnType.json:
            final decodedResponse = jsonDecode(response.body);
            return PostmonCepInfo.fromJson(decodedResponse);
          case PostmonReturnType.xml:
            final body = response.body;
            return PostmonCepInfo.fromXml(body);
        }
      } else if (response.statusCode == BAD_REQUEST) {
        return PostmonCepInfo.fromError();
      }
      return null;
    } catch (e) {
      throw Exception('Erro na comunicação com a API postmon');
    }
  }
}

String getType(PostmonReturnType returnType) {
  switch (returnType) {
    case PostmonReturnType.json:
      return 'json';
    case PostmonReturnType.xml:
      return 'xml';
  }
  return 'json';
}
