import 'package:flutter_test/flutter_test.dart';
import 'package:search_cep/src/postmon/postmon_search_cep.dart';
import 'package:search_cep/src/errors/errors.dart';
import 'package:search_cep/src/postmon/postmon_cep_info.dart';

void main() {
  group('searchInfoByCep', () {
    test('should return PostmonCepInfo if CEP exists', () async {
      // arrange
      final cep = '01001000';
      // act
      final cepInfo = await PostmonSearchCep.searchInfoByCep(cep: cep);
      final data = cepInfo.fold((_) => null, (data) => data);

      // assert
      expect(cepInfo.isRight(), true);
      expect(data, isNotNull);
      expect(data, isInstanceOf<PostmonCepInfo>());
    });

    test('should return InvalidFormatError if CEP has bad format', () async {
      // arrange
      final cep = '01001000a';

      // act
      final cepInfo = await PostmonSearchCep.searchInfoByCep(cep: cep);
      final error = cepInfo.fold<SearchCepError>((error) => error, (_) => null);

      // assert
      expect(cepInfo.isLeft(), true);
      expect(error, isNotNull);
      expect(error, isInstanceOf<InvalidFormatError>());
    });

    // TODO v

    test('should return InvalidCepError if CEP doesn\'t exist', () async {
      // arrange
      final cep = '11111111';

      // act
      final cepInfo = await PostmonSearchCep.searchInfoByCep(cep: cep);
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
}
