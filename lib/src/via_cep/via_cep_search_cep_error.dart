import 'package:search_cep/search_cep.dart';

class ViaCepSearchCepError {
  ErrorType errorType;
  String errorMessage;

  ViaCepSearchCepError(this.errorType, this.errorMessage);

  @override
  String toString() {
    return 'SearchCepError{errorMessage: $errorMessage, errorType: $errorType}';
  }
}
