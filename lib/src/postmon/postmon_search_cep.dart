import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';

import '../errors/errors.dart';
import 'postmon_cep_info.dart';

enum PostmonReturnType { json, xml }

class PostmonSearchCep {
  PostmonSearchCep({@required this.client}) : assert(client != null);

  final http.Client client;

  /// URL base do webservice via_cep
  static const String baseUrl = 'https://api.postmon.com.br/v1/cep';

  /// Constante para resposta OK do servidor
  final int ok = 200;

  /// Constante para resposta com erro do servidor
  final int badRequest = 400;

  /// Envia uma request GET para a API POSTMON enviando uma [String] com cep
  /// sem formatação. É possivel especificar o tipo de retorno através da
  /// enumeração [PostmonReturnType], podendo para este método ser json ou xml.
  /// Se não escolhido nenhum tipo de retorno o default será json.
  ///
  /// Quando consultado um CEP de formato válido, por exemplo: "01001000" o
  /// método vai retornar um objeto [PostmonCepInfo] com todas as propriedades
  /// que foram encontradas setadas.
  ///
  /// Quando consultado um CEP de formato inválido, por exemplo: "950100100"
  /// (9 dígitos), "95010A10" (alfanumérico), "95010 10" (espaço), o código de
  /// retorno da consulta será um 404 (Bad Request), o retorno conterá um
  /// objeto [PostmonCepInfo] com todos os campos de valores nulos, a
  /// propriedade [PostmonCepInfo.error] setata com true  e um campo com a
  /// mensagem descrevendo o erro na propriedade [PostmonCepInfo.errorMessage].
  /// Antes de acessar o webservice, valide o formato do CEP e certifique-se
  /// que o mesmo possua {8} dígitos.
  ///
  /// Quando consultado um CEP de formato válido, porém inexistente, por
  /// exemplo: "99999999", o retorno conterá um
  /// objeto [PostmonCepInfo] com todos os campos de valores nulos, a
  /// propriedade [PostmonCepInfo.error] setata com true  e um campo com a
  /// mensagem descrevendo o erro na propriedade [PostmonCepInfo.errorMessage].
  Future<Either<SearchCepError, PostmonCepInfo>> searchInfoByCep({
    @required String cep,
    PostmonReturnType returnType = PostmonReturnType.json,
  }) async {
    if (cep == null || cep.isEmpty || cep.length != 8) {
      return left(const InvalidFormatError());
    }
    try {
      final response = await client.get(
          '$baseUrl/$cep${returnType == PostmonReturnType.xml ? '?format=xml' : ''}');

      if (response.statusCode == ok) {
        switch (returnType) {
          case PostmonReturnType.json:
            final decodedResponse = jsonDecode(response.body);
            return right(
              PostmonCepInfo.fromJson(decodedResponse as Map<String, dynamic>),
            );
          case PostmonReturnType.xml:
            final body = response.body;
            return right(PostmonCepInfo.fromXml(body));
        }
      }
      return left(const InvalidCepError());
    } on Exception {
      return left(const NetworkError());
    }
  }
}
