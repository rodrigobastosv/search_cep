import 'dart:convert';

import 'package:http/http.dart' as http;

import 'postmon_cep_info.dart';

enum ErrorType { invalidCepFormat, nonExistentCep }
enum PostmonReturnType { json, xml }

class PostmonSearchCep {
  static const String BASE_URL = 'https://api.postmon.com.br/v1/cep';
  static const int OK = 200;
  static const int BAD_REQUEST = 404;

  /// Envia uma request GET para a API POSTMON enviando uma [String] com cep
  /// sem formatação. É possivel especificar o tipo de retorno através da
  /// enumeração [PostmonReturnType], podendo para este método ser json ou xml.
  /// Se não escolhido nenhum tipo de retorno o default será json.
  ///
  /// Quando consultado um CEP de formato válido, por exemplo: "01001000" o
  /// método vai retornar um objeto [PostmonCepInfo] com todas as propriedades que
  /// foram encontradas setadas.
  ///
  /// Quando consultado um CEP de formato inválido, por exemplo: "950100100"
  /// (9 dígitos), "95010A10" (alfanumérico), "95010 10" (espaço), o código de
  /// retorno da consulta será um 404 (Bad Request), o retorno conterá um
  /// objeto [PostmonCepInfo] com todos os campos de valores nulos, a propriedade
  /// [PostmonCepInfo.error] setata com true  e um campo com a mensagem descrevendo o
  /// erro na propriedade [PostmonCepInfo.errorMessage]. Antes de acessar o webservice,
  /// valide o formato do CEP e certifique-se que o mesmo possua {8} dígitos.
  ///
  /// Quando consultado um CEP de formato válido, porém inexistente, por
  /// exemplo: "99999999", o retorno conterá um
  /// objeto [PostmonCepInfo] com todos os campos de valores nulos, a propriedade
  /// [PostmonCepInfo.error] setata com true  e um campo com a mensagem descrevendo o
  /// erro na propriedade [PostmonCepInfo.errorMessage].
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
