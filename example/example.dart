import 'package:search_cep/search_cep.dart';
import 'package:search_cep/src/postmon/postmon_search_cep.dart';

void main() async {
  final infoCepJSON = await ViaCepSearchCep.searchInfoByCep(cep: '01001000');
  final infoCepJSON2 = await ViaCepSearchCep.searchInfoByCep(cep: '99999999');
  final infoCepJSON3 = await ViaCepSearchCep.searchInfoByCep(cep: '12345');
  final infoCepJSON4 = await ViaCepSearchCep.searchInfoByCep(cep: '30000000');

  final infoCepXML = await ViaCepSearchCep.searchInfoByCep(
      cep: '01001000', returnType: ReturnType.xml);
  final infoCepXML2 = await ViaCepSearchCep.searchInfoByCep(
      cep: '99999999', returnType: ReturnType.xml);

  final infoCepPiped = await ViaCepSearchCep.searchInfoByCep(
      cep: '01001000', returnType: ReturnType.piped);
  final infoCepPiped2 = await ViaCepSearchCep.searchInfoByCep(
      cep: '99999999', returnType: ReturnType.piped);

  final infoCepQuerty = await ViaCepSearchCep.searchInfoByCep(
      cep: '01001000', returnType: ReturnType.querty);
  final infoCepQuerty2 = await ViaCepSearchCep.searchInfoByCep(
      cep: '99999999', returnType: ReturnType.querty);

  final cepsJSON = await ViaCepSearchCep.searchForCeps(
      uf: 'RS',
      cidade: 'Porto Alegre',
      logradouro: 'Domingos',
      returnType: ReturnType.json);
  final cepsXML = await ViaCepSearchCep.searchForCeps(
      uf: 'RS',
      cidade: 'Porto Alegre',
      logradouro: 'Domingos',
      returnType: ReturnType.xml);

  final postmonInfo = await PostmonSearchCep.searchInfoByCep(cep: '60175020');
  final postmonError = await PostmonSearchCep.searchInfoByCep(cep: '000');

  print(infoCepJSON);
  print(infoCepJSON2.searchCepError);
  print(infoCepJSON3.searchCepError);
  print(infoCepJSON4);

  print(infoCepXML);
  print(infoCepXML2.searchCepError);
  print(infoCepPiped);
  print(infoCepPiped2.searchCepError);
  print(infoCepQuerty);
  print(infoCepQuerty2.searchCepError);
  print(cepsJSON);
  print(cepsXML);

  print(postmonInfo);
  print(postmonError);
}
