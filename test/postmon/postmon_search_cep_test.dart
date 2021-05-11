import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';
import 'package:search_cep/src/errors/errors.dart';
import 'package:search_cep/src/postmon/cidade_info.dart';
import 'package:search_cep/src/postmon/estado_info.dart';
import 'package:search_cep/src/postmon/postmon_cep_info.dart';
import 'package:search_cep/src/postmon/postmon_search_cep.dart';

import '../mock.dart';
import 'mock_postmon_responses.dart';

void main() {
  group('PostmonSearchCep tests', () {
    late PostmonSearchCep postmonSearchCep;
    late MockHttp mockHttp;

    setUpAll(() {
      mockHttp = MockHttp();
      postmonSearchCep = PostmonSearchCep(
        client: mockHttp,
      );
      registerFallbackValue<Uri>(Uri());
    });

    test('PostmonCepInfo toString()', () {
      final instance = PostmonCepInfo(
        cep: '00000000',
        logradouro: 'logradouro',
        bairro: 'bairro',
        cidade: 'cidade',
        estado: 'estado',
        cidadeInfo: CidadeInfo(
          areaKm2: 'areaKm2',
          codigoIbge: 'codigoIbge',
        ),
        estadoInfo: EstadoInfo(
          codigoIbge: 'codigoIbge',
          areaKm2: 'areaKm2',
          nome: 'nome',
        ),
      );
      expect(
        instance.toString(),
        '''PostmonCepInfo{bairro: bairro, cidade: cidade, logradouro: logradouro, estadoInfo: EstadoInfo{areaKm2: areaKm2, codigoIbge: codigoIbge, nome: nome}, cep: 00000000, cidadeInfo: CidadeInfo{areaKm2: areaKm2, codigoIbge: codigoIbge}, estado: estado}''',
      );
    });

    group('searchInfoByCep', () {
      group('should return PostmonCepInfo if CEP exists', () {
        test('with json', () async {
          // arrange
          const cep = '01001000';
          when(
            () => mockHttp.get(any()),
          ).thenAnswer(
            (_) => Future.value(
              http.Response(
                jsonResponse,
                200,
              ),
            ),
          );

          // act
          final cepInfo = await postmonSearchCep.searchInfoByCep(cep: cep);
          final data = cepInfo.fold((_) => null, (data) => data);

          // assert
          expect(cepInfo.isRight(), true);
          expect(data, isNotNull);
          expect(data, isInstanceOf<PostmonCepInfo>());
        });

        test('with xml', () async {
          // arrange
          const cep = '01001000';
          when(
            () => mockHttp.get(any()),
          ).thenAnswer(
            (_) => Future.value(
              http.Response(
                xmlResponse,
                200,
              ),
            ),
          );

          // act
          final cepInfo = await postmonSearchCep.searchInfoByCep(
            cep: cep,
            returnType: PostmonReturnType.xml,
          );
          final data = cepInfo.fold((_) => null, (data) => data);

          // assert
          expect(cepInfo.isRight(), true);
          expect(data, isNotNull);
          expect(data, isInstanceOf<PostmonCepInfo>());
        });
      });

      test('should return InvalidFormatError if CEP has bad format', () async {
        // arrange
        const cep = '01001000a';

        // act
        final cepInfo = await postmonSearchCep.searchInfoByCep(cep: cep);
        final error =
            cepInfo.fold<SearchCepError?>((error) => error, (_) => null);

        // assert
        expect(cepInfo.isLeft(), true);
        expect(error, isNotNull);
        expect(error, isInstanceOf<InvalidFormatError>());
      });

      test('should return InvalidCepError if CEP doesnt exist', () async {
        // arrange
        const cep = '11111111';
        when(
          () => mockHttp.get(any()),
        ).thenAnswer(
          (_) => Future.value(
            http.Response(
              jsonResponse,
              400,
            ),
          ),
        );

        // act
        final cepInfo = await postmonSearchCep.searchInfoByCep(cep: cep);
        final error =
            cepInfo.fold<SearchCepError?>((error) => error, (_) => null);

        // assert
        expect(cepInfo.isLeft(), true);
        expect(error, isNotNull);
        expect(error, isInstanceOf<InvalidCepError>());
      });

      test('should return NetworkError when exception is thrown', () async {
        // arrange
        const cep = '11111111';
        when(
          () => mockHttp.get(any()),
        ).thenThrow(
          Exception(),
        );

        // act
        final cepInfo = await postmonSearchCep.searchInfoByCep(cep: cep);
        final error =
            cepInfo.fold<SearchCepError?>((error) => error, (_) => null);

        // assert
        expect(cepInfo.isLeft(), true);
        expect(error, isNotNull);
        expect(error, isInstanceOf<NetworkError>());
      });
    });
  });
}
