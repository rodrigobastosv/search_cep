const jsonResponse = '''
  {"bairro": "Aldeota", "cidade": "Fortaleza", "logradouro": "Rua Fonseca Lobo", "estado_info": {"area_km2": "148.887,632", "codigo_ibge": "23", "nome": "Cear\u00e1"}, "cep": "60175020", "cidade_info": {"area_km2": "314,93", "codigo_ibge": "2304400"}, "estado": "CE"}
''';

const xmlResponse = '''
  <?xml version="1.0" encoding="utf-8"?>
  <result><bairro>Aldeota</bairro><cidade>Fortaleza</cidade><logradouro>Rua Fonseca Lobo</logradouro><estado_info><area_km2>148.887,632</area_km2><codigo_ibge>23</codigo_ibge><nome>CearÃ¡</nome></estado_info><cep>60175020</cep><cidade_info><area_km2>314,93</area_km2><codigo_ibge>2304400</codigo_ibge></cidade_info><estado>CE</estado></result>
''';
