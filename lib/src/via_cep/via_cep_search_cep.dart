import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:search_cep/src/errors/errors.dart';

import 'via_cep_info.dart';

enum ReturnType { json, xml, piped, querty }

class ViaCepSearchCep {
  /// URL base do webservice via_cep
  static const String BASE_URL = 'https://viacep.com.br/ws';

  /// Constante para resposta OK do servidor
  static const int OK = 200;

  /// Constante para resposta com erro do servidor
  static const int BAD_REQUEST = 400;

  /// Envia uma request GET para a API do via_cep enviando uma [String] com cep
  /// sem formatação. É possivel especificar o tipo de retorno através da
  /// enumeração [ReturnType], podendo para este método ser json, xml, piped ou
  /// querty. Se não escolhido nenhum tipo de retorno o default será json.
  ///
  /// Quando consultado um CEP de formato válido, por exemplo: "01001000" o
  /// método vai retornar um objeto [ViaCepCepInfo] com todas as propriedades que
  /// foram encontradas setadas.
  ///
  /// Quando consultado um CEP de formato inválido, por exemplo: "950100100"
  /// (9 dígitos), "95010A10" (alfanumérico), "95010 10" (espaço), o código de
  /// retorno da consulta será um 400 (Bad Request), o retorno conterá um
  /// objeto [ViaCepCepInfo] com todos os campos de valores nulos, a propriedade
  /// [ViaCepCepInfo.error] setata com true  e um campo com a mensagem descrevendo o
  /// erro na propriedade [ViaCepCepInfo.errorMessage]. Antes de acessar o webservice,
  /// valide o formato do CEP e certifique-se que o mesmo possua {8} dígitos.
  ///
  /// Quando consultado um CEP de formato válido, porém inexistente, por
  /// exemplo: "99999999", o retorno conterá um objeto [ViaCepCepInfo] com todos os
  /// campos de valores nulos, a propriedade [ViaCepCepInfo.error] setata com true
  /// e um campo com a mensagem descrevendo o erro na propriedade
  /// [ViaCepCepInfo.errorMessage].
  ///
  static Future<Either<SearchCepError, ViaCepInfo>> searchInfoByCep(
      {String cep, ReturnType returnType = ReturnType.json}) async {
    try {
      final response = await http.get('$BASE_URL/$cep/${getType(returnType)}');

      if (response.statusCode == OK) {
        switch (returnType) {
          case ReturnType.json:
            final decodedResponse = jsonDecode(response.body);
            if (decodedResponse['erro'] == true) {
              return left(InvalidCepError());
            }
            return right(ViaCepInfo.fromJson(decodedResponse));
          case ReturnType.xml:
            final body = response.body;
            if (body.contains('erro')) {
              return left(InvalidCepError());
            }
            return right(ViaCepInfo.fromXml(body));
          case ReturnType.piped:
            final body = response.body;
            if (body.contains('erro')) {
              return left(InvalidCepError());
            }
            return right(ViaCepInfo.fromPiped(body));
          case ReturnType.querty:
            final body = response.body;
            if (body.contains('erro')) {
              return left(InvalidCepError());
            }
            return right(ViaCepInfo.fromQuerty(body));
        }
      } else if (response.statusCode == BAD_REQUEST) {
        return left(InvalidFormatError());
      }
      return null;
    } catch (e) {
      throw NetworkError();
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
  static Future<Either<SearchCepError, List<ViaCepInfo>>> searchForCeps({
    String uf,
    String cidade,
    String logradouro,
    ReturnType returnType = ReturnType.json,
  }) async {
    try {
      final response = await http
          .get('$BASE_URL/$uf/$cidade/$logradouro/${getType(returnType)}');

      if (response.statusCode == OK) {
        switch (returnType) {
          case ReturnType.json:
            final listInfo = jsonDecode(response.body);
            return right(List.generate(
                listInfo.length, (int i) => ViaCepInfo.fromJson(listInfo[i])));
          case ReturnType.xml:
            return right(ViaCepInfo.toListXml(response.body));
          case ReturnType.piped:
            return left(SearchCepError(
                'Opção de retorno não implementada para este método'));
          case ReturnType.querty:
            return left(SearchCepError(
                'Opção de retorno não implementada para este método'));
        }
      }
      return left(InvalidFormatError(
          'Nome da cidade e logradouro tem que ter ao menos três caracteres'));
    } catch (e) {
      return left(NetworkError(e.toString()));
    }
  }
}

/// Precisamos mapear o enum de retorno com a string que a API recebe
String getType(ReturnType returnType) {
  switch (returnType) {
    case ReturnType.json:
      return 'json';
    case ReturnType.xml:
      return 'xml';
    case ReturnType.piped:
      return 'piped';
    case ReturnType.querty:
      return 'querty';
  }
  return 'json';
}
