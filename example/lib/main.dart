import 'package:search_cep/search_cep.dart';
import 'package:search_cep/src/postmon/postmon_search_cep.dart';

void main() async {
  final viaCepSearchCep = ViaCepSearchCep();
  final infoCepJSON = await viaCepSearchCep.searchInfoByCep(cep: '01001000');
  final infoCepJSON2 = await viaCepSearchCep.searchInfoByCep(cep: '99999999');
  final infoCepJSON3 = await viaCepSearchCep.searchInfoByCep(cep: '12345');
  final infoCepJSON4 = await viaCepSearchCep.searchInfoByCep(cep: '30000000');

  final infoCepXML = await viaCepSearchCep.searchInfoByCep(
      cep: '01001000', returnType: SearchInfoType.xml);
  final infoCepXML2 = await viaCepSearchCep.searchInfoByCep(
      cep: '99999999', returnType: SearchInfoType.xml);

  final infoCepPiped = await viaCepSearchCep.searchInfoByCep(
      cep: '01001000', returnType: SearchInfoType.piped);
  final infoCepPiped2 = await viaCepSearchCep.searchInfoByCep(
      cep: '99999999', returnType: SearchInfoType.piped);

  final infoCepQuerty = await viaCepSearchCep.searchInfoByCep(
      cep: '01001000', returnType: SearchInfoType.querty);
  final infoCepQuerty2 = await viaCepSearchCep.searchInfoByCep(
      cep: '99999999', returnType: SearchInfoType.querty);

  final cepsJSON = await viaCepSearchCep.searchForCeps(
    uf: 'RS',
    cidade: 'Porto Alegre',
    logradouro: 'Domingos',
    returnType: SearchCepsType.json,
  );
  final cepsXML = await viaCepSearchCep.searchForCeps(
    uf: 'RS',
    cidade: 'Porto Alegre',
    logradouro: 'Domingos',
    returnType: SearchCepsType.xml,
  );

  final postmonSearchCep = PostmonSearchCep();
  final postmonInfo = await postmonSearchCep.searchInfoByCep(cep: '60175020');
  final postmonError = await postmonSearchCep.searchInfoByCep(cep: '000');

  print(infoCepJSON.fold((_) => null, (data) => data));
  print(infoCepJSON2.fold((l) => l.errorMessage, (r) => r));
  print(infoCepJSON3.fold((l) => l.errorMessage, (r) => r));
  print(infoCepJSON4.fold((_) => null, (data) => data));

  print(infoCepXML.fold((_) => null, (data) => data));
  print(infoCepXML2.fold((l) => l.errorMessage, (r) => r));
  print(infoCepPiped.fold((_) => null, (data) => data));
  print(infoCepPiped2.fold((l) => l.errorMessage, (r) => r));

  print(infoCepQuerty.fold((_) => null, (data) => data));
  print(infoCepQuerty2.fold((l) => l.errorMessage, (r) => r));

  print(cepsJSON.fold((_) => null, (data) => data));
  print(cepsXML.fold((_) => null, (data) => data));

  print(postmonInfo.fold((_) => null, (data) => data));
  print(postmonError.fold((l) => l.errorMessage, (r) => r));
}
