import 'dart:convert';

import 'package:xml2json/xml2json.dart' as xml;

import 'cidade_info.dart';
import 'estado_info.dart';

class PostmonCepInfo {
  String bairro;
  String cidade;
  String logradouro;
  String cep;
  String estado;
  CidadeInfo cidadeInfo;
  EstadoInfo estadoInfo;

  PostmonCepInfo({
    this.bairro,
    this.cidade,
    this.logradouro,
    this.cep,
    this.estado,
    this.estadoInfo,
    this.cidadeInfo,
  });

  PostmonCepInfo.fromJson(Map<String, dynamic> json) {
    bairro = json['bairro'] as String;
    cidade = json['cidade'] as String;
    logradouro = json['logradouro'] as String;
    cep = json['cep'] as String;
    estado = json['estado'] as String;
    estadoInfo = json['estado_info'] != null
        ? EstadoInfo.fromJson(json['estado_info'] as Map<String, dynamic>)
        : null;
    cidadeInfo = json['cidade_info'] != null
        ? CidadeInfo.fromJson(json['cidade_info'] as Map<String, dynamic>)
        : null;
  }

  PostmonCepInfo.fromXml(String content) {
    final myTransformer = xml.Xml2Json();
    myTransformer.parse(content);
    content = myTransformer.toParker();

    final decodedData = jsonDecode(content)['result'];
    PostmonCepInfo.fromJson(decodedData as Map<String, dynamic>);
  }

  @override
  String toString() {
    return '''PostmonCepInfo{bairro: $bairro, cidade: $cidade, logradouro: $logradouro, estadoInfo: $estadoInfo, cep: $cep, cidadeInfo: $cidadeInfo, estado: $estado}''';
  }
}
