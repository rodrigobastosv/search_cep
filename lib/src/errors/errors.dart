class SearchCepError {
  final String errorMessage;

  const SearchCepError(this.errorMessage);

  @override
  String toString() {
    return 'SearchCepError{errorMessage: $errorMessage}';
  }
}

class InvalidFormatError extends SearchCepError {
  const InvalidFormatError([String message])
      : super(message ?? 'CEP com formato inválido');
}

class InvalidCepError extends SearchCepError {
  const InvalidCepError([String message])
      : super(message ?? 'CEP inexistente.');
}

class NetworkError extends SearchCepError {
  const NetworkError([String message])
      : super(message ?? 'Erro na comunicação com a API');
}
