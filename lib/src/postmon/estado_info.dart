class EstadoInfo {
  String? areaKm2;
  String? codigoIbge;
  String? nome;

  EstadoInfo({
    this.areaKm2,
    this.codigoIbge,
    this.nome,
  });

  EstadoInfo.fromJson(Map<String, dynamic> json) {
    areaKm2 = json['area_km2'] as String;
    codigoIbge = json['codigo_ibge'] as String;
    nome = json['nome'] as String;
  }

  @override
  String toString() {
    return '''EstadoInfo{areaKm2: $areaKm2, codigoIbge: $codigoIbge, nome: $nome}''';
  }
}
