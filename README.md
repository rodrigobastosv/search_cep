Pacote criado para ser uma abstração e facilitar o uso da API https://viacep.com.br/. A API via_cep é totalmente gratuita e possui 
alto desempenho, sendo possível consultar diversos Códigos de Endereçamento Postal (CEP) do Brasil. Utilize o serviço a vontade e
se possível ajude a mantê-lo atualizado.
 
O pacote fornece uma classe com métodos estáticos para fazer os dois tipos de pesquisas disponibilizados pela API que são: pesquisa 
por cep, onde o usuário manda uma String com o CEP e recebe várias informações daquele CEP, ou pesquisa por localidades, onde
o usuário passa uma UF, uma cidade e um logradouro e a API retorna uma lista de CEP's dentro daquela área. Neste último caso 
o resultado será ordenado pela proximidade do nome do logradouro e possui limite máximo de 50 (cinquenta) CEPs. 
Desta forma, quanto mais específico os parâmentros de entrada maior será a precisão do resultado.
 
## Como Usar
  
O exemplo básico de uso consiste em passar uma String sem formatação com o CEP e o pacote vai retornar um objeto 
intitulado CepInfo com as informações retornadas pela API.

```dart
void main() async {
  final infoCepJSON = await SearchCep.searchInfoByCep(cep: '01001000');
  print(infoCepJSON);
}
```

O print do exemplo acima vai ser um objeto no formato indicado abaixo:

```javascript
CepInfo{cep: 01001-000, logradouro: Praça da Sé, complemento: lado ímpar, bairro: Sé, localidade: São Paulo, uf: SP, unidade: , ibge: 3550308, gia: 1004, errorMessage: null, error: false}
```

Um exemplo que pode acontecer é o cep passado pelo usuário ser uma String válida mas pode ser que ele não exista, como
no exemplo abaixo:

```dart
void main() async {
  final infoCepJSON = await SearchCep.searchInfoByCep(cep: '99999999');
  print(infoCepJSON);
}
```

Neste caso o objeto CepInfo vai vir com todos os campos de valores nulos e uma mensagem no campo
`errorMessage` indicando qual erro ocorreu. Além disso o campo `error` do mesmo objeto virá com o
valor true, indicando que algum erro ocorreu.

```javascript
CepInfo{cep: null, logradouro: null, complemento: null, bairro: null, localidade: null, uf: null, unidade: null, ibge: null, gia: null, errorMessage: CEP com formato válido, porém inexistente na base de dados, error: true}
```

No caso da String com cep passada não ser válida o objeto InfoCep retornado vai ser equivalente a esse:

```javascript
CepInfo{cep: null, logradouro: null, complemento: null, bairro: null, localidade: null, uf: null, unidade: null, ibge: null, gia: null, errorMessage: CEP com formato inválido, error: true}
```

Outra forma de pesquisa suportada pela API é a pesquisa por localidades. Um exemplo de pesquisa desta é mostrado abaixo:

```dart
void main() async {
  final cepsJSON = await SearchCep.searchForCeps(uf: 'RS', cidade: 'Porto Alegre', logradouro: 'Domingos', returnType: ReturnType.json);
  print(cepsJSON);
}
```

E o retorno do método vai ser uma lista com vários objetos (no máximo 50) InfoCep.

```javascript
[CepInfo{cep: 91420-270, logradouro: Rua São Domingos, complemento: , bairro: Bom Jesus, localidade: Porto Alegre, uf: RS, unidade: , ibge: 4314902, gia: , errorMessage: null, error: false}, CepInfo{cep: 91040-000, logradouro: Rua Domingos Rubbo, complemento: , bairro: Cristo Redentor, localidade: Porto Alegre, uf: RS, unidade: , ibge: 4314902, gia: , errorMessage: null, error: false}, CepInfo{cep: 91040-320, logradouro: Rua Domingos Martins, complemento: , bairro: Cristo Redentor, localidade: Porto Alegre, uf: RS, unidade: , ibge: 4314902, gia: , errorMessage: null, error: false}, CepInfo{cep: 91910-450, logradouro: Rua Domingos da Silva, complemento: , bairro: Camaquã, localidade: Porto Alegre, uf: RS, unidade: , ibge: 4314902, gia: , errorMessage: null, error: false}, CepInfo{cep: 91120-090, logradouro: Rua Domingos de Abreu, complemento: , bairro: Sarandi, localidade: Porto Alegre, uf: RS, unidade: , ibge: 4314902, gia: , errorMessage: null, error: false}, CepInfo{cep: 91360-040, logradouro: Rua Domingos Seguézio, complemento: , bairro: Vila Ipiranga, localidade: Porto Alegre, uf: RS, unidade: , ibge: 4314902, gia: , errorMessage: null, error: false}, CepInfo{cep: 91790-072, logradouro: Rua Domingos José Poli, complemento: , bairro: Restinga, localidade: Porto Alegre, uf: RS, unidade: , ibge: 4314902, gia: , errorMessage: null, error: false}, CepInfo{cep: 91160-080, logradouro: Rua Luiz Domingos Ramos, complemento: , bairro: Santa Rosa de Lima, localidade: Porto Alegre, uf: RS, unidade: , ibge: 4314902, gia: , errorMessage: null, error: false}, CepInfo{cep: 90650-090, logradouro: Rua Domingos Crescêncio, complemento: , bairro: Santana, localidade: Porto Alegre, uf: RS, unidade: , ibge: 4314902, gia: , errorMessage: null, error: false}, CepInfo{cep: 91910-420, logradouro: Rua José Domingos Varella, complemento: , bairro: Cavalhada, localidade: Porto Alegre, uf: RS, unidade: , ibge: 4314902, gia: , errorMessage: null, error: false}, CepInfo{cep: 91790-101, logradouro: Rua Domingos Manoel Mincarone, complemento: , bairro: Restinga, localidade: Porto Alegre, uf: RS, unidade: , ibge: 4314902, gia: , errorMessage: null, error: false}, CepInfo{cep: 91120-480, logradouro: Rua Domingos Antônio Santoro, complemento: , bairro: Sarandi, localidade: Porto Alegre, uf: RS, unidade: , ibge: 4314902, gia: , errorMessage: null, error: false}, CepInfo{cep: 91261-304, logradouro: Rua Domingos Mullet Rodrigues, complemento: , bairro: Mário Quintana, localidade: Porto Alegre, uf: RS, unidade: , ibge: 4314902, gia: , errorMessage: null, error: false}, CepInfo{cep: 90420-200, logradouro: Rua Domingos José de Almeida, complemento: , bairro: Rio Branco, localidade: Porto Alegre, uf: RS, unidade: , ibge: 4314902, gia: , errorMessage: null, error: false}, CepInfo{cep: 91540-650, logradouro: Acesso Olavo Domingos de Oliveira, complemento: , bairro: Jardim Carvalho, localidade: Porto Alegre, uf: RS, unidade: , ibge: 4314902, gia: , errorMessage: null, error: false}, CepInfo{cep: 91740-650, logradouro: Praça Domingos Fernandes de Souza, complemento: , bairro: Cavalhada, localidade: Porto Alegre, uf: RS, unidade: , ibge: 4314902, gia: , errorMessage: null, error: false}]
```

## API via_cep

Para mais informações sobre a API e para ajudar a mantê-la atualizada [via_cep][viacep].

## Sugestões, Melhorias e Bugs

Para sugerir melhorias ou para apontar algum bug [issue tracker][tracker].

[tracker]: https://github.com/rodrigobastosv/search_cep/issues
[viacep]: https://www.viacep.com.br

