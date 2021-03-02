class SearchCepError {
  final String errorMessage;

  const SearchCepError(this.errorMessage);

  @override
  String toString() {
    return 'SearchCepError{errorMessage: $errorMessage}';
  }
}

/// Erro lançado quando o CEP informado tem formato inválido
class InvalidFormatError extends SearchCepError {
  const InvalidFormatError([String? message])
      : super(message ?? 'CEP com formato inválido');
}

/// Erro lançado quando o CEP não existe na base de dados
class InvalidCepError extends SearchCepError {
  const InvalidCepError([String? message])
      : super(message ?? 'CEP inexistente.');
}

/// Erro lançado quando não é possível estabelecer conexão com a API ou a API
/// retorna algum erro interno
class NetworkError extends SearchCepError {
  const NetworkError([String? message])
      : super(message ?? 'Erro na comunicação com a API');
}
