import 'dart:convert';

import 'package:search_cep/src/via_cep/via_cep_search_cep_error.dart';
import 'package:xml2json/xml2json.dart' as xml;

import '../../search_cep.dart';

class ViaCepInfo {
  String cep;
  String logradouro;
  String complemento;
  String bairro;
  String localidade;
  String uf;
  String unidade;
  String ibge;
  String gia;
  bool hasError;
  ViaCepSearchCepError searchCepError;

  ViaCepInfo(
      {this.cep,
      this.logradouro,
      this.complemento,
      this.bairro,
      this.localidade,
      this.uf,
      this.unidade,
      this.ibge,
      this.gia});

  ViaCepInfo.fromJson(Map<String, dynamic> json) {
    cep = json['cep'];
    logradouro = json['logradouro'];
    complemento = json['complemento'];
    bairro = json['bairro'];
    localidade = json['localidade'];
    uf = json['uf'];
    unidade = json['unidade'];
    ibge = json['ibge'];
    gia = json['gia'];
    hasError = false;
  }

  ViaCepInfo.fromXml(String content) {
    xml.Xml2Json myTransformer = xml.Xml2Json();
    myTransformer.parse(content);
    content = myTransformer.toParker();

    Map<String, dynamic> decodedData = jsonDecode(content)['xmlcep'];

    cep = decodedData['cep'];
    logradouro = decodedData['logradouro'];
    complemento = decodedData['complemento'];
    bairro = decodedData['bairro'];
    localidade = decodedData['localidade'];
    uf = decodedData['uf'];
    unidade = decodedData['unidade'];
    ibge = decodedData['ibge'];
    gia = decodedData['gia'];
    hasError = false;
  }

  ViaCepInfo.fromPiped(String content) {
    final splited = content.split('|');

    cep = splited[0].split(':')[1];
    logradouro = splited[1].split(':')[1];
    complemento = splited[2].split(':')[1];
    bairro = splited[3].split(':')[1];
    localidade = splited[4].split(':')[1];
    uf = splited[5].split(':')[1];
    unidade = splited[6].split(':')[1];
    ibge = splited[7].split(':')[1];
    gia = splited[8].split(':')[1];
    hasError = false;
  }

  ViaCepInfo.fromQuerty(String content) {
    final querted = content.replaceAll('+', ' ').split('&');

    cep = querted[0].split('=')[1];
    logradouro = querted[1].split('=')[1];
    complemento = querted[2].split('=')[1];
    bairro = querted[3].split('=')[1];
    localidade = querted[4].split('=')[1];
    uf = querted[5].split('=')[1];
    unidade = querted[6].split('=')[1];
    ibge = querted[7].split('=')[1];
    gia = querted[8].split('=')[1];
    hasError = false;
  }

  ViaCepInfo.fromError(ErrorType errorType) {
    final errorMessage = errorType == ErrorType.invalidCepFormat
        ? 'CEP com formato inválido'
        : 'CEP com formato válido, porém inexistente na base de dados';
    searchCepError = ViaCepSearchCepError(errorType, errorMessage);
    hasError = true;
  }

  static List<ViaCepInfo> toListXml(String content) {
    xml.Xml2Json myTransformer = xml.Xml2Json();
    myTransformer.parse(content);
    content = myTransformer.toParker();

    Map<String, dynamic> decodedData = jsonDecode(content)['xmlcep'];
    if (decodedData['enderecos'] == null) {
      return [];
    }
    final enderecos = decodedData['enderecos']['endereco'];
    return List.generate(
        enderecos.length, (i) => ViaCepInfo.fromJson(enderecos[i]));
  }

  @override
  String toString() {
    return 'ViaCepInfo{cep: $cep, logradouro: $logradouro, complemento: $complemento, bairro: $bairro, localidade: $localidade, uf: $uf, unidade: $unidade, ibge: $ibge, gia: $gia, searchCepError: $searchCepError}';
  }
}
