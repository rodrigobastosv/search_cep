const jsonResponse = '''
  {cep: 60175-020, logradouro: Rua Fonseca Lobo, complemento: , bairro: Aldeota, localidade: Fortaleza, uf: CE, unidade: , ibge: 2304400, gia: }
''';

const listCepsJsonResponse = '''
  [
    {
      "cep": "91420-270",
      "logradouro": "Rua São Domingos",
      "complemento": "",
      "bairro": "Bom Jesus",
      "localidade": "Porto Alegre",
      "uf": "RS",
      "unidade": "",
      "ibge": "4314902",
      "gia": ""
    },
    {
      "cep": "91040-000",
      "logradouro": "Rua Domingos Rubbo",
      "complemento": "",
      "bairro": "Cristo Redentor",
      "localidade": "Porto Alegre",
      "uf": "RS",
      "unidade": "",
      "ibge": "4314902",
      "gia": ""
    },
    {
      "cep": "91040-320",
      "logradouro": "Rua Domingos Martins",
      "complemento": "",
      "bairro": "Cristo Redentor",
      "localidade": "Porto Alegre",
      "uf": "RS",
      "unidade": "",
      "ibge": "4314902",
      "gia": ""
    },
    {
      "cep": "91910-450",
      "logradouro": "Rua Domingos da Silva",
      "complemento": "",
      "bairro": "Camaquã",
      "localidade": "Porto Alegre",
      "uf": "RS",
      "unidade": "",
      "ibge": "4314902",
      "gia": ""
    },
    {
      "cep": "91120-090",
      "logradouro": "Rua Domingos de Abreu",
      "complemento": "",
      "bairro": "Sarandi",
      "localidade": "Porto Alegre",
      "uf": "RS",
      "unidade": "",
      "ibge": "4314902",
      "gia": ""
    },
    {
      "cep": "91360-040",
      "logradouro": "Rua Domingos Seguézio",
      "complemento": "",
      "bairro": "Vila Ipiranga",
      "localidade": "Porto Alegre",
      "uf": "RS",
      "unidade": "",
      "ibge": "4314902",
      "gia": ""
    },
    {
      "cep": "91790-072",
      "logradouro": "Rua Domingos José Poli",
      "complemento": "",
      "bairro": "Restinga",
      "localidade": "Porto Alegre",
      "uf": "RS",
      "unidade": "",
      "ibge": "4314902",
      "gia": ""
    },
    {
      "cep": "91160-080",
      "logradouro": "Rua Luiz Domingos Ramos",
      "complemento": "",
      "bairro": "Santa Rosa de Lima",
      "localidade": "Porto Alegre",
      "uf": "RS",
      "unidade": "",
      "ibge": "4314902",
      "gia": ""
    },
    {
      "cep": "90650-090",
      "logradouro": "Rua Domingos Crescêncio",
      "complemento": "",
      "bairro": "Santana",
      "localidade": "Porto Alegre",
      "uf": "RS",
      "unidade": "",
      "ibge": "4314902",
      "gia": ""
    },
    {
      "cep": "91910-420",
      "logradouro": "Rua José Domingos Varella",
      "complemento": "",
      "bairro": "Cavalhada",
      "localidade": "Porto Alegre",
      "uf": "RS",
      "unidade": "",
      "ibge": "4314902",
      "gia": ""
    },
    {
      "cep": "91790-101",
      "logradouro": "Rua Domingos Manoel Mincarone",
      "complemento": "",
      "bairro": "Restinga",
      "localidade": "Porto Alegre",
      "uf": "RS",
      "unidade": "",
      "ibge": "4314902",
      "gia": ""
    },
    {
      "cep": "91120-480",
      "logradouro": "Rua Domingos Antônio Santoro",
      "complemento": "",
      "bairro": "Sarandi",
      "localidade": "Porto Alegre",
      "uf": "RS",
      "unidade": "",
      "ibge": "4314902",
      "gia": ""
    },
    {
      "cep": "91261-304",
      "logradouro": "Rua Domingos Mullet Rodrigues",
      "complemento": "",
      "bairro": "Mário Quintana",
      "localidade": "Porto Alegre",
      "uf": "RS",
      "unidade": "",
      "ibge": "4314902",
      "gia": ""
    },
    {
      "cep": "90420-200",
      "logradouro": "Rua Domingos José de Almeida",
      "complemento": "",
      "bairro": "Rio Branco",
      "localidade": "Porto Alegre",
      "uf": "RS",
      "unidade": "",
      "ibge": "4314902",
      "gia": ""
    },
    {
      "cep": "91540-650",
      "logradouro": "Acesso Olavo Domingos de Oliveira",
      "complemento": "",
      "bairro": "Jardim Carvalho",
      "localidade": "Porto Alegre",
      "uf": "RS",
      "unidade": "",
      "ibge": "4314902",
      "gia": ""
    },
    {
      "cep": "91740-650",
      "logradouro": "Praça Domingos Fernandes de Souza",
      "complemento": "",
      "bairro": "Cavalhada",
      "localidade": "Porto Alegre",
      "uf": "RS",
      "unidade": "",
      "ibge": "4314902",
      "gia": ""
    }
  ]
''';

const listCepsXmlResponse = '''
  <?xml version="1.0" encoding="UTF-8"?>
  <xmlcep>
    <enderecos>
      <endereco>
        <cep>91420-270</cep>
        <logradouro>Rua SÃ£o Domingos</logradouro>
        <complemento></complemento>
        <bairro>Bom Jesus</bairro>
        <localidade>Porto Alegre</localidade>
        <uf>RS</uf>
        <unidade></unidade>
        <ibge>4314902</ibge>
        <gia></gia>
      </endereco>
      <endereco>
        <cep>91040-000</cep>
        <logradouro>Rua Domingos Rubbo</logradouro>
        <complemento></complemento>
        <bairro>Cristo Redentor</bairro>
        <localidade>Porto Alegre</localidade>
        <uf>RS</uf>
        <unidade></unidade>
        <ibge>4314902</ibge>
        <gia></gia>
      </endereco>
      <endereco>
        <cep>91040-320</cep>
        <logradouro>Rua Domingos Martins</logradouro>
        <complemento></complemento>
        <bairro>Cristo Redentor</bairro>
        <localidade>Porto Alegre</localidade>
        <uf>RS</uf>
        <unidade></unidade>
        <ibge>4314902</ibge>
        <gia></gia>
      </endereco>
      <endereco>
        <cep>91910-450</cep>
        <logradouro>Rua Domingos da Silva</logradouro>
        <complemento></complemento>
        <bairro>CamaquÃ£</bairro>
        <localidade>Porto Alegre</localidade>
        <uf>RS</uf>
        <unidade></unidade>
        <ibge>4314902</ibge>
        <gia></gia>
      </endereco>
      <endereco>
        <cep>91120-090</cep>
        <logradouro>Rua Domingos de Abreu</logradouro>
        <complemento></complemento>
        <bairro>Sarandi</bairro>
        <localidade>Porto Alegre</localidade>
        <uf>RS</uf>
        <unidade></unidade>
        <ibge>4314902</ibge>
        <gia></gia>
      </endereco>
      <endereco>
        <cep>91360-040</cep>
        <logradouro>Rua Domingos SeguÃ©zio</logradouro>
        <complemento></complemento>
        <bairro>Vila Ipiranga</bairro>
        <localidade>Porto Alegre</localidade>
        <uf>RS</uf>
        <unidade></unidade>
        <ibge>4314902</ibge>
        <gia></gia>
      </endereco>
      <endereco>
        <cep>91790-072</cep>
        <logradouro>Rua Domingos JosÃ© Poli</logradouro>
        <complemento></complemento>
        <bairro>Restinga</bairro>
        <localidade>Porto Alegre</localidade>
        <uf>RS</uf>
        <unidade></unidade>
        <ibge>4314902</ibge>
        <gia></gia>
      </endereco>
      <endereco>
        <cep>91160-080</cep>
        <logradouro>Rua Luiz Domingos Ramos</logradouro>
        <complemento></complemento>
        <bairro>Santa Rosa de Lima</bairro>
        <localidade>Porto Alegre</localidade>
        <uf>RS</uf>
        <unidade></unidade>
        <ibge>4314902</ibge>
        <gia></gia>
      </endereco>
      <endereco>
        <cep>90650-090</cep>
        <logradouro>Rua Domingos CrescÃªncio</logradouro>
        <complemento></complemento>
        <bairro>Santana</bairro>
        <localidade>Porto Alegre</localidade>
        <uf>RS</uf>
        <unidade></unidade>
        <ibge>4314902</ibge>
        <gia></gia>
      </endereco>
      <endereco>
        <cep>91910-420</cep>
        <logradouro>Rua JosÃ© Domingos Varella</logradouro>
        <complemento></complemento>
        <bairro>Cavalhada</bairro>
        <localidade>Porto Alegre</localidade>
        <uf>RS</uf>
        <unidade></unidade>
        <ibge>4314902</ibge>
        <gia></gia>
      </endereco>
      <endereco>
        <cep>91790-101</cep>
        <logradouro>Rua Domingos Manoel Mincarone</logradouro>
        <complemento></complemento>
        <bairro>Restinga</bairro>
        <localidade>Porto Alegre</localidade>
        <uf>RS</uf>
        <unidade></unidade>
        <ibge>4314902</ibge>
        <gia></gia>
      </endereco>
      <endereco>
        <cep>91120-480</cep>
        <logradouro>Rua Domingos AntÃ´nio Santoro</logradouro>
        <complemento></complemento>
        <bairro>Sarandi</bairro>
        <localidade>Porto Alegre</localidade>
        <uf>RS</uf>
        <unidade></unidade>
        <ibge>4314902</ibge>
        <gia></gia>
      </endereco>
      <endereco>
        <cep>91261-304</cep>
        <logradouro>Rua Domingos Mullet Rodrigues</logradouro>
        <complemento></complemento>
        <bairro>MÃ¡rio Quintana</bairro>
        <localidade>Porto Alegre</localidade>
        <uf>RS</uf>
        <unidade></unidade>
        <ibge>4314902</ibge>
        <gia></gia>
      </endereco>
      <endereco>
        <cep>90420-200</cep>
        <logradouro>Rua Domingos JosÃ© de Almeida</logradouro>
        <complemento></complemento>
        <bairro>Rio Branco</bairro>
        <localidade>Porto Alegre</localidade>
        <uf>RS</uf>
        <unidade></unidade>
        <ibge>4314902</ibge>
        <gia></gia>
      </endereco>
      <endereco>
        <cep>91540-650</cep>
        <logradouro>Acesso Olavo Domingos de Oliveira</logradouro>
        <complemento></complemento>
        <bairro>Jardim Carvalho</bairro>
        <localidade>Porto Alegre</localidade>
        <uf>RS</uf>
        <unidade></unidade>
        <ibge>4314902</ibge>
        <gia></gia>
      </endereco>
      <endereco>
        <cep>91740-650</cep>
        <logradouro>PraÃ§a Domingos Fernandes de Souza</logradouro>
        <complemento></complemento>
        <bairro>Cavalhada</bairro>
        <localidade>Porto Alegre</localidade>
        <uf>RS</uf>
        <unidade></unidade>
        <ibge>4314902</ibge>
        <gia></gia>
      </endereco>
    </enderecos>
  </xmlcep>
''';

const listCepsXmlWithoutAddressesResponse = '''
  <?xml version="1.0" encoding="UTF-8"?>
  <xmlcep>
    <enderecos>
    </enderecos>
  </xmlcep>
''';

const xmlResponse = '''
  <?xml version="1.0" encoding="UTF-8"?>
  <xmlcep>
  <cep>60175-020</cep>
  <logradouro>Rua Fonseca Lobo</logradouro>
  <complemento></complemento>
  <bairro>Aldeota</bairro>
  <localidade>Fortaleza</localidade>
  <uf>CE</uf>
  <unidade></unidade>
  <ibge>2304400</ibge>
  <gia></gia>
  </xmlcep>
''';

const pipedResponse = '''
  cep:60175-020|logradouro:Rua Fonseca Lobo|complemento:|bairro:Aldeota|localidade:Fortaleza|uf:CE|unidade:|ibge:2304400|gia:
''';

const qwertyResponse = '''
  cep=60175-020&logradouro=Rua%20Fonseca%20Lobo&complemento=&bairro=Aldeota&localidade=Fortaleza&uf=CE&unidade=&ibge=2304400&gia=
''';
