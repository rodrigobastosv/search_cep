import 'package:flutter_test/flutter_test.dart';

import 'package:search_cep/src/via_cep/via_cep_search_cep.dart';
import 'package:search_cep/src/via_cep/via_cep_info.dart';
import 'package:search_cep/src/errors/errors.dart';

void main() {
  group('searchInfoByCep', () {
    test('should return ViaCepInfo if CEP exists', () async {
      // arrange
      const cep = '01001000';

      // act
      final cepInfo = await ViaCepSearchCep.searchInfoByCep(cep: cep);
      final data = cepInfo.fold((_) => null, (data) => data);

      // assert
      expect(cepInfo.isRight(), true);
      expect(data, isNotNull);
      expect(data, isInstanceOf<ViaCepInfo>());
    });
    test('should return InvalidFormatError if CEP has bad format', () async {
      // arrange
      const cep = '01001000a';

      // act
      final cepInfo = await ViaCepSearchCep.searchInfoByCep(cep: cep);
      final error = cepInfo.fold<SearchCepError>((error) => error, (_) => null);

      // assert
      expect(cepInfo.isLeft(), true);
      expect(error, isNotNull);
      expect(error, isInstanceOf<InvalidFormatError>());
    });
    test('should return InvalidCepError if CEP doesn\'t exist', () async {
      // arrange
      const cep = '11111111';

      // act
      final cepInfo = await ViaCepSearchCep.searchInfoByCep(cep: cep);
      final error = cepInfo.fold<SearchCepError>((error) => error, (_) => null);

      // assert
      expect(cepInfo.isLeft(), true);
      expect(error, isNotNull);
      expect(error, isInstanceOf<InvalidCepError>());
    });
    test('should return NetworkError if there was a Network issue', () {
      // TODO refactor to allow NetworkError to be Mockable
      expect(false, true);
    });
  });
  group('searchForCeps', () {
    test('should return a list of CEPs in json', () async {
      // act
      final cepInfo = await ViaCepSearchCep.searchForCeps(
        uf: 'RS',
        cidade: 'Porto Alegre',
        logradouro: 'Domingos',
        returnType: SearchCepsType.json,
      );
      final data = cepInfo.fold<List<ViaCepInfo>>((_) => null, (data) => data);

      // assert
      expect(cepInfo.isRight(), true);
      expect(data, isNotNull);
      expect(data, isInstanceOf<List<ViaCepInfo>>());
    });
    test('should return a list of CEPs in xml', () async {
      // act
      final cepInfo = await ViaCepSearchCep.searchForCeps(
        uf: 'RS',
        cidade: 'Porto Alegre',
        logradouro: 'Domingos',
        returnType: SearchCepsType.xml,
      );
      final data = cepInfo.fold<List<ViaCepInfo>>((_) => null, (data) => data);

      // assert
      expect(cepInfo.isRight(), true);
      expect(data, isNotNull);
      expect(data, isInstanceOf<List<ViaCepInfo>>());
    });
  });
}
