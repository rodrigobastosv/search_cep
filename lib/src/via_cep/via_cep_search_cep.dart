import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

import '../errors/errors.dart';
import 'via_cep_info.dart';

/// Enum que guarda o tipo de busca que será feito
enum SearchInfoType {
  json,
  xml,
  piped,
  querty,
}

/// Enum que guarda o tipo de busca que será feito em caso de busca por CEP
enum SearchCepsType {
  json,
  xml,
}

class ViaCepSearchCep {
  ViaCepSearchCep({
    http.Client? client,
  }) : _client = client ?? http.Client();

  late final http.Client _client;

  http.Client get client => _client;

  /// URL base do webservice via_cep
  final String baseUrl = 'https://viacep.com.br/ws';

  /// Constante para resposta OK do servidor
  final int ok = 200;

  /// Constante para resposta com erro do servidor
  final int badRequest = 400;

  /// Envia uma request GET para a API do via_cep enviando uma [String] com cep
  /// sem formatação. É possivel especificar o tipo de retorno através da
  /// enumeração [ReturnType], podendo para este método ser json, xml, piped ou
  /// querty. Se não escolhido nenhum tipo de retorno o default será json.
  ///
  /// Quando consultado um CEP de formato válido, por exemplo: "01001000" o
  /// método vai retornar um objeto [ViaCepCepInfo] com todas as propriedades
  /// que foram encontradas setadas.
  ///
  /// Quando consultado um CEP de formato inválido, por exemplo: "950100100"
  /// (9 dígitos), "95010A10" (alfanumérico), "95010 10" (espaço), o código de
  /// retorno da consulta será um 400 (Bad Request), o retorno conterá um
  /// objeto [ViaCepCepInfo] com todos os campos de valores nulos, a propriedade
  /// [ViaCepCepInfo.error] setata com true  e um campo com a mensagem
  /// descrevendo o erro na propriedade [ViaCepCepInfo.errorMessage]. Antes de
  /// acessar o webservice,valide o formato do CEP e certifique-se que o mesmo
  /// possua {8} dígitos.
  ///
  /// Quando consultado um CEP de formato válido, porém inexistente, por
  /// exemplo: "99999999", o retorno conterá um objeto [ViaCepCepInfo] com
  /// todos os campos de valores nulos, a propriedade [ViaCepCepInfo.error]
  /// setata com true e um campo com a mensagem descrevendo o erro na
  /// propriedade [ViaCepCepInfo.errorMessage].
  ///
  Future<Either<SearchCepError, ViaCepInfo>> searchInfoByCep({
    required String cep,
    SearchInfoType returnType = SearchInfoType.json,
  }) async {
    if (cep.isEmpty || cep.length != 8) {
      return left(const InvalidFormatError());
    }
    try {
      final uri = Uri.parse('$baseUrl/$cep/${getType(returnType)}');
      final response = await _client.get(uri);
      if (response.statusCode == ok) {
        switch (returnType) {
          case SearchInfoType.json:
            final decodedResponse =
                jsonDecode(response.body) as Map<String, dynamic>;
            if (decodedResponse['erro'] == true) {
              return left(const InvalidCepError());
            }
            return right(ViaCepInfo.fromJson(decodedResponse));
          case SearchInfoType.xml:
            final body = response.body;
            if (body.contains('erro')) {
              return left(const InvalidCepError());
            }
            return right(ViaCepInfo.fromXml(body));
          case SearchInfoType.piped:
            final body = response.body;
            if (body.contains('erro')) {
              return left(const InvalidCepError());
            }
            return right(ViaCepInfo.fromPiped(body));
          case SearchInfoType.querty:
            final body = response.body;
            if (body.contains('erro')) {
              return left(const InvalidCepError());
            }
            return right(ViaCepInfo.fromQuerty(body));
        }
      } else if (response.statusCode == badRequest) {
        return left(const InvalidFormatError());
      } else {
        throw Exception();
      }
    } on Exception {
      return left(const NetworkError());
    }
  }

  /// Envia uma request GET para a API do via_cep enviando uma [String] com uf
  /// uma [String] com cidade e outra com endereço. É possivel especificar o
  /// tipo de retorno através da enumeração [ReturnType], podendo para este
  /// método ser json ou xml. Se não escolhido nenhum tipo de retorno o default
  /// será json.
  ///
  /// Existem necessidades, por exemplo um cadastramento online onde o cliente
  /// desconhece o CEP da sua rua e será necessário realizar uma pesquisa para
  /// verificar a existência de um CEP que corresponda ao endereço. Para
  /// consultar um CEP na base de dados são necessários três parâmetros
  /// obrigatórios (UF, Cidade e Logradouro), sendo que para Cidade e Logradouro
  /// também é obrigatório um número mínimo de três caracteres a fim de evitar
  /// resultados muito abrangentes.
  ///
  /// O resultado será ordenado pela proximidade do nome do logradouro e possui
  /// limite máximo de 50 (cinquenta) CEPs. Desta forma, quanto mais específico
  /// os parâmentros de entrada maior será a precisão do resultado.
  ///
  /// O resultado será uma [List] de objetos [CepInfo].
  ///
  /// Ex:
  /// uf = 'RS'
  /// cidade = 'Porto Alegre'
  /// endereco = 'Domingos'
  ///
  /// uf = 'RS'
  /// cidade = 'Porto Alegre'
  /// endereco = 'Domingos Jose'
  ///
  /// uf = 'RS'
  /// cidade = 'Porto Alegre'
  /// endereco = 'Domingos+Jose'
  ///
  /// Os exemplos acima demonstram diferentes formar de pesquisar pelas
  /// ocorrências "Domingos" e "José" na cidade de "Porto Algre/RS".
  ///
  /// Quando o nome da cidade ou do logradouro não contiver ao menos três
  /// caracteres uma exceção será lançada.
  ///
  Future<Either<SearchCepError, List<ViaCepInfo>>> searchForCeps({
    required String uf,
    required String cidade,
    required String logradouro,
    SearchCepsType returnType = SearchCepsType.json,
  }) async {
    try {
      final type = getTypeSearchCeps(returnType);

      final uri = Uri.parse('$baseUrl/$uf/$cidade/$logradouro/$type');
      final response = await _client.get(uri);

      if (response.statusCode == ok) {
        switch (returnType) {
          case SearchCepsType.json:
            final listInfo = jsonDecode(response.body) as List;
            return right(List.generate(
                listInfo.length,
                (i) =>
                    ViaCepInfo.fromJson(listInfo[i] as Map<String, dynamic>)));
          case SearchCepsType.xml:
            return right(ViaCepInfo.toListXml(response.body));
        }
      }
      return left(const InvalidFormatError(
          'Nome da cidade e logradouro tem que ter ao menos três caracteres'));
    } on Exception {
      return left(const NetworkError());
    }
  }
}

/// Precisamos mapear o enum de retorno com a string que a API recebe
String getType(SearchInfoType returnType) {
  return returnType.toString().split('.').last;
}

String getTypeSearchCeps(SearchCepsType returnType) {
  return returnType.toString().split('.').last;
}
