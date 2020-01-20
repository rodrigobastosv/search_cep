import 'package:search_cep/search_cep.dart';

class SearchCepError {
  ErrorType errorType;
  String errorMessage;

  SearchCepError(this.errorType, this.errorMessage);

  @override
  String toString() {
    return 'SearchCepError{errorMessage: $errorMessage, errorType: $errorType}';
  }
}
