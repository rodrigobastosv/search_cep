import 'package:search_cep/search_cep.dart';

void main() async {
  final infoCepJSON = await SearchCep.searchInfoByCep(cep: '01001000');
  final infoCepJSON2 = await SearchCep.searchInfoByCep(cep: '99999999');
  final infoCepJSON3 = await SearchCep.searchInfoByCep(cep: '12345');

  final infoCepXML = await SearchCep.searchInfoByCep(
      cep: '01001000', returnType: ReturnType.xml);
  final infoCepXML2 = await SearchCep.searchInfoByCep(
      cep: '99999999', returnType: ReturnType.xml);

  final infoCepPiped = await SearchCep.searchInfoByCep(
      cep: '01001000', returnType: ReturnType.piped);
  final infoCepPiped2 = await SearchCep.searchInfoByCep(
      cep: '99999999', returnType: ReturnType.piped);

  final infoCepQuerty = await SearchCep.searchInfoByCep(
      cep: '01001000', returnType: ReturnType.querty);
  final infoCepQuerty2 = await SearchCep.searchInfoByCep(
      cep: '99999999', returnType: ReturnType.querty);

  final cepsJSON = await SearchCep.searchForCeps(
      uf: 'RS',
      cidade: 'Porto Alegre',
      logradouro: 'Domingos',
      returnType: ReturnType.json);
  final cepsXML = await SearchCep.searchForCeps(
      uf: 'RS',
      cidade: 'Porto Alegre',
      logradouro: 'Domingos',
      returnType: ReturnType.xml);

  print(infoCepJSON);
  print(infoCepJSON2.searchCepError);
  print(infoCepJSON3.searchCepError);
  print(infoCepXML);
  print(infoCepXML2.searchCepError);
  print(infoCepPiped);
  print(infoCepPiped2.searchCepError);
  print(infoCepQuerty);
  print(infoCepQuerty2.searchCepError);
  print(cepsJSON);
  print(cepsXML);
}
