import 'dart:convert';

import 'package:search_cep/src/postmon/postmon_search_cep_error.dart';
import 'package:xml2json/xml2json.dart' as xml;

class PostmonCepInfo {
  String bairro;
  String cidade;
  String logradouro;
  EstadoInfo estadoInfo;
  String cep;
  CidadeInfo cidadeInfo;
  String estado;
  bool hasError;
  PostmonSearchCepError postmonSearchCepError;

  PostmonCepInfo(
      {this.bairro,
      this.cidade,
      this.logradouro,
      this.estadoInfo,
      this.cep,
      this.cidadeInfo,
      this.estado});

  PostmonCepInfo.fromJson(Map<String, dynamic> json) {
    bairro = json['bairro'];
    cidade = json['cidade'];
    logradouro = json['logradouro'];
    estadoInfo = json['estado_info'] != null
        ? new EstadoInfo.fromJson(json['estado_info'])
        : null;
    cep = json['cep'];
    cidadeInfo = json['cidade_info'] != null
        ? new CidadeInfo.fromJson(json['cidade_info'])
        : null;
    estado = json['estado'];
    hasError = false;
  }

  PostmonCepInfo.fromXml(String content) {
    xml.Xml2Json myTransformer = xml.Xml2Json();
    myTransformer.parse(content);
    content = myTransformer.toParker();

    Map<String, dynamic> decodedData = jsonDecode(content)['result'];
    print(decodedData);
    cep = decodedData['cep'];
    cidade = decodedData['cidade'];
    logradouro = decodedData['logradouro'];
    bairro = decodedData['bairro'];
    estado = decodedData['estado'];
    estadoInfo = EstadoInfo.fromJson(decodedData['estado_info']);
    cidadeInfo = CidadeInfo.fromJson(decodedData['cidade_info']);
    hasError = false;
  }

  PostmonCepInfo.fromError() {
    postmonSearchCepError = PostmonSearchCepError('CEP não encontrado');
    hasError = true;
  }

  @override
  String toString() {
    return 'PostmonCepInfo{bairro: $bairro, cidade: $cidade, logradouro: $logradouro, estadoInfo: $estadoInfo, cep: $cep, cidadeInfo: $cidadeInfo, estado: $estado, hasError: $hasError, postmonSearchCepError: $postmonSearchCepError}';
  }
}

class EstadoInfo {
  String areaKm2;
  String codigoIbge;
  String nome;

  EstadoInfo({this.areaKm2, this.codigoIbge, this.nome});

  EstadoInfo.fromJson(Map<String, dynamic> json) {
    areaKm2 = json['area_km2'];
    codigoIbge = json['codigo_ibge'];
    nome = json['nome'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['area_km2'] = this.areaKm2;
    data['codigo_ibge'] = this.codigoIbge;
    data['nome'] = this.nome;
    return data;
  }

  @override
  String toString() {
    return 'EstadoInfo{areaKm2: $areaKm2, codigoIbge: $codigoIbge, nome: $nome}';
  }
}

class CidadeInfo {
  String areaKm2;
  String codigoIbge;

  CidadeInfo({this.areaKm2, this.codigoIbge});

  CidadeInfo.fromJson(Map<String, dynamic> json) {
    areaKm2 = json['area_km2'];
    codigoIbge = json['codigo_ibge'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['area_km2'] = this.areaKm2;
    data['codigo_ibge'] = this.codigoIbge;
    return data;
  }

  @override
  String toString() {
    return 'CidadeInfo{areaKm2: $areaKm2, codigoIbge: $codigoIbge}';
  }
}
