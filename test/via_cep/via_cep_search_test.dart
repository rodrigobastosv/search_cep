import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:search_cep/src/errors/errors.dart';
import 'package:search_cep/src/via_cep/via_cep_info.dart';
import 'package:search_cep/src/via_cep/via_cep_search_cep.dart';

import '../mock.dart';
import 'mock_via_cep_responses.dart';

void main() {
  group('ViaCepSearchCep tests', () {
    ViaCepSearchCep viaCepSearchCep;
    MockHttp mockHttp;

    setUpAll(() {
      mockHttp = MockHttp();
      viaCepSearchCep = ViaCepSearchCep(
        client: mockHttp,
      );
    });

    test('asserts', () {
      expect(() => ViaCepSearchCep(client: null), throwsAssertionError);
    });

    test('ViaCepInfo toString()', () {
      final instance = ViaCepInfo(
        cep: '00000000',
        logradouro: 'logradouro',
        localidade: 'localidade',
        bairro: 'bairro',
        complemento: 'complemento',
        gia: 'gia',
        ibge: 'ibge',
        uf: 'uf',
        unidade: 'unidade',
      );
      expect(
        instance.toString(),
        '''ViaCepInfo{cep: 00000000, logradouro: logradouro, complemento: complemento, bairro: bairro, localidade: localidade, uf: uf, unidade: unidade, ibge: ibge, gia: gia}''',
      );
    });

    group('searchInfoByCep', () {
      test('should return ViaCepInfo from json if CEP exists', () async {
        // arrange
        const cep = '01001000';
        final body = {'body': 'info'};
        when(mockHttp.get('https://viacep.com.br/ws/$cep/json')).thenAnswer(
          (_) => Future.value(
            http.Response(
              jsonEncode(body),
              200,
            ),
          ),
        );

        // act
        final cepInfo = await viaCepSearchCep.searchInfoByCep(cep: cep);
        final data = cepInfo.fold((_) => null, (data) => data);

        // assert
        expect(cepInfo.isRight(), true);
        expect(data, isNotNull);
        expect(data, isInstanceOf<ViaCepInfo>());
      });

      test('should return ViaCepInfo from xml if CEP exists', () async {
        // arrange
        // arrange
        const cep = '01001000';
        when(mockHttp.get('https://viacep.com.br/ws/$cep/xml')).thenAnswer(
          (_) => Future.value(
            http.Response(
              xmlResponse,
              200,
            ),
          ),
        );

        // act
        final cepInfo = await viaCepSearchCep.searchInfoByCep(
          cep: cep,
          returnType: SearchInfoType.xml,
        );
        final data = cepInfo.fold((_) => null, (data) => data);

        // assert
        expect(cepInfo.isRight(), true);
        expect(data, isNotNull);
        expect(data, isInstanceOf<ViaCepInfo>());
      });

      test('should return ViaCepInfo piped if CEP exists', () async {
        // arrange
        const cep = '01001000';
        when(mockHttp.get('https://viacep.com.br/ws/$cep/piped')).thenAnswer(
          (_) => Future.value(
            http.Response(
              pipedResponse,
              200,
            ),
          ),
        );

        // act
        final cepInfo = await viaCepSearchCep.searchInfoByCep(
          cep: cep,
          returnType: SearchInfoType.piped,
        );
        final data = cepInfo.fold((_) => null, (data) => data);

        // assert
        expect(cepInfo.isRight(), true);
        expect(data, isNotNull);
        expect(data, isInstanceOf<ViaCepInfo>());
      });

      test('should return ViaCepInfo from querty if CEP exists', () async {
        // arrange
        const cep = '01001000';
        when(mockHttp.get('https://viacep.com.br/ws/$cep/querty')).thenAnswer(
          (_) => Future.value(
            http.Response(
              qwertyResponse,
              200,
            ),
          ),
        );

        // act
        final cepInfo = await viaCepSearchCep.searchInfoByCep(
          cep: cep,
          returnType: SearchInfoType.querty,
        );
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
        final cepInfo = await viaCepSearchCep.searchInfoByCep(cep: cep);
        final error =
            cepInfo.fold<SearchCepError>((error) => error, (_) => null);

        // assert
        expect(cepInfo.isLeft(), true);
        expect(error, isNotNull);
        expect(error, isInstanceOf<InvalidFormatError>());
      });

      test('should return InvalidFormatError when api returns 400', () async {
        // arrange
        const cep = '00000000';
        when(mockHttp.get('https://viacep.com.br/ws/$cep/json')).thenAnswer(
          (_) => Future.value(
            http.Response(
              qwertyResponse,
              400,
            ),
          ),
        );

        // act
        final cepInfo = await viaCepSearchCep.searchInfoByCep(cep: cep);
        final error =
            cepInfo.fold<SearchCepError>((error) => error, (_) => null);

        // assert
        expect(cepInfo.isLeft(), true);
        expect(error, isNotNull);
        expect(error, isInstanceOf<InvalidFormatError>());
      });

      test('should return NetworkError when exception occurs', () async {
        // arrange
        const cep = '60175020';
        when(mockHttp.get('https://viacep.com.br/ws/$cep/querty')).thenThrow(
          Exception(),
        );

        // act
        final cepInfo = await viaCepSearchCep.searchInfoByCep(cep: cep);
        final error =
            cepInfo.fold<SearchCepError>((error) => error, (_) => null);

        // assert
        expect(cepInfo.isLeft(), true);
        expect(error, isNotNull);
        expect(error, isInstanceOf<NetworkError>());
      });

      group('InvalidCepError tests', () {
        test('with json', () async {
          final body = {'erro': true};
          when(mockHttp.get('https://viacep.com.br/ws/00000000/json'))
              .thenAnswer(
            (_) => Future.value(
              http.Response(
                jsonEncode(body),
                200,
              ),
            ),
          );
          final cepInfo = await viaCepSearchCep.searchInfoByCep(
            cep: '00000000',
            returnType: SearchInfoType.json,
          );
          final error =
              cepInfo.fold<SearchCepError>((error) => error, (_) => null);
          expect(cepInfo.isLeft(), true);
          expect(error, isNotNull);
          expect(error, isInstanceOf<InvalidCepError>());
        });

        test('with xml', () async {
          final body = {'erro': 'Deu erro'};
          when(mockHttp.get('https://viacep.com.br/ws/00000000/xml'))
              .thenAnswer(
            (_) => Future.value(
              http.Response(
                jsonEncode(body),
                200,
              ),
            ),
          );
          final cepInfo = await viaCepSearchCep.searchInfoByCep(
            cep: '00000000',
            returnType: SearchInfoType.xml,
          );
          final error =
              cepInfo.fold<SearchCepError>((error) => error, (_) => null);
          expect(cepInfo.isLeft(), true);
          expect(error, isNotNull);
          expect(error, isInstanceOf<InvalidCepError>());
        });

        test('with querty', () async {
          final body = {'erro': 'Deu erro'};
          when(mockHttp.get('https://viacep.com.br/ws/00000000/querty'))
              .thenAnswer(
            (_) => Future.value(
              http.Response(
                jsonEncode(body),
                200,
              ),
            ),
          );
          final cepInfo = await viaCepSearchCep.searchInfoByCep(
            cep: '00000000',
            returnType: SearchInfoType.querty,
          );
          final error =
              cepInfo.fold<SearchCepError>((error) => error, (_) => null);
          expect(cepInfo.isLeft(), true);
          expect(error, isNotNull);
          expect(error, isInstanceOf<InvalidCepError>());
        });

        test('with piped', () async {
          final body = {'erro': 'Deu erro'};
          when(mockHttp.get('https://viacep.com.br/ws/00000000/piped'))
              .thenAnswer(
            (_) => Future.value(
              http.Response(
                jsonEncode(body),
                200,
              ),
            ),
          );
          final cepInfo = await viaCepSearchCep.searchInfoByCep(
            cep: '00000000',
            returnType: SearchInfoType.piped,
          );
          final error =
              cepInfo.fold<SearchCepError>((error) => error, (_) => null);
          expect(cepInfo.isLeft(), true);
          expect(error, isNotNull);
          expect(error, isInstanceOf<InvalidCepError>());
        });
      });
    });

    group('searchForCeps', () {
      test('should return a list of CEPs in json', () async {
        // act
        when(mockHttp
                .get('https://viacep.com.br/ws/RS/Porto Alegre/Domingos/json'))
            .thenAnswer(
          (_) => Future.value(http.Response(
            listCepsJsonResponse,
            200,
          )),
        );
        final cepInfo = await viaCepSearchCep.searchForCeps(
          uf: 'RS',
          cidade: 'Porto Alegre',
          logradouro: 'Domingos',
          returnType: SearchCepsType.json,
        );
        final data =
            cepInfo.fold<List<ViaCepInfo>>((_) => null, (data) => data);

        // assert
        expect(cepInfo.isRight(), true);
        expect(data, isNotNull);
        expect(data, isInstanceOf<List<ViaCepInfo>>());
      });

      test('should return a list of CEPs in xml', () async {
        // act
        when(mockHttp
                .get('https://viacep.com.br/ws/RS/Porto Alegre/Domingos/xml'))
            .thenAnswer(
          (_) => Future.value(
            http.Response(
              listCepsXmlResponse,
              200,
            ),
          ),
        );
        final cepInfo = await viaCepSearchCep.searchForCeps(
          uf: 'RS',
          cidade: 'Porto Alegre',
          logradouro: 'Domingos',
          returnType: SearchCepsType.xml,
        );
        final data =
            cepInfo.fold<List<ViaCepInfo>>((_) => null, (data) => data);

        // assert
        expect(cepInfo.isRight(), true);
        expect(data, isNotNull);
        expect(data, isInstanceOf<List<ViaCepInfo>>());
      });

      test('should return InvalidFormatError when api sends 404', () async {
        // act
        when(
          mockHttp.get(any),
        ).thenAnswer(
          (_) => Future.value(
            http.Response(
              listCepsXmlResponse,
              404,
            ),
          ),
        );
        final cepInfo = await viaCepSearchCep.searchForCeps(
          uf: 'RS',
          cidade: 'Porto Alegre',
          logradouro: 'Domingos',
          returnType: SearchCepsType.xml,
        );

        final error =
            cepInfo.fold<SearchCepError>((error) => error, (_) => null);
        expect(cepInfo.isLeft(), true);
        expect(error, isNotNull);
        expect(error, isInstanceOf<InvalidFormatError>());
      });

      test('should return empty array when response doesnt have any address',
          () async {
        // act
        when(
          mockHttp.get(any),
        ).thenAnswer(
          (_) => Future.value(
            http.Response(
              listCepsXmlWithoutAddressesResponse,
              200,
            ),
          ),
        );
        final cepInfo = await viaCepSearchCep.searchForCeps(
          uf: 'RS',
          cidade: 'Porto Alegre',
          logradouro: 'Domingos',
          returnType: SearchCepsType.xml,
        );

        final data =
            cepInfo.fold<List<ViaCepInfo>>((_) => null, (data) => data);

        // assert
        expect(cepInfo.isRight(), true);
        expect(data, isNotNull);
        expect(data, isEmpty);
        expect(data, isInstanceOf<List<ViaCepInfo>>());
      });

      test('should return NetworkError when exception occurs', () async {
        // act
        when(
          mockHttp.get(any),
        ).thenThrow(
          Exception(),
        );
        final cepInfo = await viaCepSearchCep.searchForCeps(
          uf: 'RS',
          cidade: 'Porto Alegre',
          logradouro: 'Domingos',
          returnType: SearchCepsType.xml,
        );

        final error =
            cepInfo.fold<SearchCepError>((error) => error, (_) => null);
        expect(cepInfo.isLeft(), true);
        expect(error, isNotNull);
        expect(error, isInstanceOf<NetworkError>());
      });
    });
  });
}
