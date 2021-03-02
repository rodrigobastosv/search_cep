class CidadeInfo {
  String? areaKm2;
  String? codigoIbge;

  CidadeInfo({
    this.areaKm2,
    this.codigoIbge,
  });

  CidadeInfo.fromJson(Map<String, dynamic> json) {
    areaKm2 = json['area_km2'] as String;
    codigoIbge = json['codigo_ibge'] as String;
  }

  @override
  String toString() {
    return 'CidadeInfo{areaKm2: $areaKm2, codigoIbge: $codigoIbge}';
  }
}
