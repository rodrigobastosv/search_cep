import 'package:flutter_test/flutter_test.dart';
import 'package:search_cep/src/errors/errors.dart';

void main() {
  group('SearchCepError tests', () {
    test('toString()', () {
      const instance = SearchCepError('error');
      expect(instance.toString(), 'SearchCepError{errorMessage: error}');
    });

    test('const', () {
      // ignore: prefer_const_constructors
      expect(SearchCepError('error') == const SearchCepError('error'), false);
      // ignore: prefer_const_constructors
      expect(InvalidFormatError('error') == const InvalidFormatError('error'),
          false);
      // ignore: prefer_const_constructors
      expect(InvalidCepError('error') == const InvalidCepError('error'), false);
      // ignore: prefer_const_constructors
      expect(NetworkError('error') == const NetworkError('error'), false);
    });
  });
}
