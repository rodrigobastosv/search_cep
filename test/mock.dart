import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:mocktail/mocktail.dart';

class MockHttp extends Mock implements http.Client {}

class UriFake extends Fake implements Uri {}

class MockResponse extends Mock implements Response {}