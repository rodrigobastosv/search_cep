import 'dart:convert';

import 'package:xml2json/xml2json.dart' as xml;

class ViaCepInfo {
  String? cep;
  String? logradouro;
  String? complemento;
  String? bairro;
  String? localidade;
  String? uf;
  String? unidade;
  String? ibge;
  String? gia;

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

  /// Desserializa de json
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
  }

  /// Desserializa de xml
  ViaCepInfo.fromXml(String content) {
    final myTransformer = xml.Xml2Json();
    myTransformer.parse(content);
    content = myTransformer.toParker();

    final decodedData = jsonDecode(content)['xmlcep'];
    ViaCepInfo.fromJson(decodedData as Map<String, dynamic>);
  }

  /// Desserializa de piped
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
  }

  /// Desserializa de qwerty
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
  }

  static List<ViaCepInfo> toListXml(String content) {
    final myTransformer = xml.Xml2Json();
    myTransformer.parse(content);
    final transformed = myTransformer.toParker();

    final decodedData = jsonDecode(transformed)['xmlcep'];
    if (decodedData['enderecos'] == null) {
      return [];
    }
    final enderecos = decodedData['enderecos']['endereco'] as List;
    return List.generate(enderecos.length,
        (i) => ViaCepInfo.fromJson(enderecos[i] as Map<String, dynamic>));
  }

  @override
  String toString() {
    return '''ViaCepInfo{cep: $cep, logradouro: $logradouro, complemento: $complemento, bairro: $bairro, localidade: $localidade, uf: $uf, unidade: $unidade, ibge: $ibge, gia: $gia}''';
  }
}
