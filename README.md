<p align="center">
  <a href="https://github.com/bittencourtthulio/safety4d/blob/main/assets/logo.fw.png">
    <img alt="safety4d" src="https://github.com/bittencourtthulio/safety4d/blob/main/assets/logo.fw.png">
  </a>  
</p>
<br>
<p align="center">
  <img src="https://img.shields.io/github/v/release/bittencourtthulio/safety4d?style=flat-square">
  <img src="https://img.shields.io/github/stars/bittencourtthulio/safety4d?style=flat-square">
  <img src="https://img.shields.io/github/contributors/bittencourtthulio/safety4d?color=orange&style=flat-square">
  <img src="https://img.shields.io/github/forks/bittencourtthulio/safety4d?style=flat-square">
   <img src="https://tokei.rs/b1/github/bittencourtthulio/safety4d?color=red&category=lines">
  <img src="https://tokei.rs/b1/github/bittencourtthulio/safety4d?color=green&category=code">
  <img src="https://tokei.rs/b1/github/bittencourtthulio/safety4d?color=yellow&category=files">
</p>

# Safety4D
Framework para Controle de Regras de Acesso de Usuários inspirado no conceito RBAC.


### About the name
This is called safety and not security intentionally because its creator wanted it that way.

## Instalação
Basta registrar no Library Path do seu Delphi o caminho da pasta SRC da Biblioteca ou utilizar o Boss (https://github.com/HashLoad/boss) para facilitar ainda mais, executando o comando 

```
boss install https://github.com/bittencourtthulio/safety4d
```

## Primeiros Passos - Tutorial

Para utilizar o Safety4D você deve adicionar a uses

```
Safety4D
```

### Como funciona

O Safety4D foi baseado no conceito de RBAC ( role-based access control) https://pt.wikipedia.org/wiki/Controle_de_acesso_baseado_em_fun%C3%A7%C3%B5es

Ele se baseia em uma estrutura JSON de configuração para definição das permissões, inspirada na estrutura utilizada pelo Windows Azure. 

https://docs.microsoft.com/pt-br/azure/role-based-access-control/overview

Abaixo o exemplo de um arquivo de configuração

```JSON
{
    "resources": {
        "safety4d": {
            "users": {
                "actions": {
                    "read": {
                        "description": "read-only",
                        "errormsg": "not permit"
                    },
                    "write": {
                        "description": "read-write",
                        "errormsg": "not write data"
                    },
                    "delete": {
                        "description": "delete-data",
                        "errormsg": "not delete data"
                    },
                    "view": {
                        "description": "view data",
                        "errormsg": "not view data"
                    }
                }
            }
        }
    },
    "groupPermission": {
        "{4D62E4C3-C73D-488A-8518-03A9545B5611}": {
            "key": "Gerente",
            "description": "Permissoes completa de gestao do Sistema",
            "Actions": [
                "users.write"
            ],
            "NotActions": [
                "*"
            ]
        },
        "{C188D1AB-EC28-4380-96E0-D1B13A29A8B3}": {
            "key": "Comercial",
            "description": "Permissoes de Recursos Comerciais",
            "Actions": [
                "*"
            ],
            "NotActions": [
                "users.delete",
                "users.write"
            ]
        }
    },
    "userKeys": {
        "{34C940ED-50E7-4CE3-B701-03CF1E15F28B}": {
            "description": "Fulano de Tal",
            "permissionGroups": [
                "{4D62E4C3-C73D-488A-8518-03A9545B5611}"
            ]
        },
        "{96B4C46F-0EBB-443B-B309-09C81844406E}": {
            "description": "Beltrano",
            "permissionGroups": [
                "{C188D1AB-EC28-4380-96E0-D1B13A29A8B3}"
            ]
        }
    }
}
```

## Explicando a Estrutura

Abaixo vou detalhar cada bloco do JSON acima explicando o objetivo e a aplicação de cada recurso.


### Resources

Neste bloco você vai cadastrar a sua aplicação, os recursos dela e as ações que você deseja validar.

```JSON
"resources": {
        "safety4d": {
            "users": {
                "actions": {
                    "read": {
                        "description": "read-only",
                        "errormsg": "not permit"
                    },
                    "write": {
                        "description": "read-write",
                        "errormsg": "not write data"
                    },
                    "delete": {
                        "description": "delete-data",
                        "errormsg": "not delete data"
                    },
                    "view": {
                        "description": "view data",
                        "errormsg": "not view data"
                    }
                }
            }
        }
    },
```

No exemplo acima, estamos cadastrando a aplicação chamada <b>safety4d</b>, o recursos chamados <b>users</b> e as ações disponíveis neste recurso <b> read, write, delete, view </b>. 
Você pode cadastrar quantas ações desejar para um recurso.

### Group Permission

Neste bloco você cria os grupos de permissão que serão atribuidos aos usuários, definindo quais recursos e actions podem e não podem ser acessados pelos usuários do grupo.

No bloco <b>Actions</b> você define todos os recursos e actions que os participantes do grupo terão acesso, e no bloco <b>NotActions</b> você define todos os recursos e actions que estarão bloqueados para os participantes do grupo.

Utilizando o caracter <b>"*"</b> no bloco <b>Actions</b> você está liberando o acesso a todos os recursos exceto aqueles que estiverem especificados na sessão <b>NotActions</b>.

Utilizando o caracter <b>"*"</b> no bloco <b>NotActions</b> você está bloqueando o acesso a todos os recursos exceto aqueles que estiverem especificados na sessão <b>Actions</b>.

```JSON
 "groupPermission": {
        "{4D62E4C3-C73D-488A-8518-03A9545B5611}": {
            "key": "Gerente",
            "description": "Permissoes completa de gestao do Sistema",
            "Actions": [
                "users.write"
            ],
            "NotActions": [
                "*"
            ]
        },
        "{C188D1AB-EC28-4380-96E0-D1B13A29A8B3}": {
            "key": "Comercial",
            "description": "Permissoes de Recursos Comerciais",
            "Actions": [
                "*"
            ],
            "NotActions": [
                "users.delete",
                "users.write"
            ]
        }
    },
```

No exemplo acima cadastramos 2 grupos de permissões distindos, no primeiro grupo <b>Gerente</b> definimos em <b>Actions</b> que os participantes desse grupo só podem acessar o recurso <b>users</b> executando a ação <b>write</b> e o caracter <b>"*"</b> na sessão <b>NotActions</b> sinaliza que todas as demais funções estão bloqueadas.

No segundo grupo todas as <b>Actions</b> estão liberadas, exceto as que estão descritas no bloco <b>NotActions</b>.
 

 ### User Keys

 Neste bloco você cadastra as chaves referentes aos usuários do sistema, atribuindo a eles as keys dos Grupos de Permissões que ele participa.

 ```JSON
  "userKeys": {
        "{34C940ED-50E7-4CE3-B701-03CF1E15F28B}": {
            "description": "Fulano de Tal",
            "permissionGroups": [
                "{4D62E4C3-C73D-488A-8518-03A9545B5611}"
            ]
        },
        "{96B4C46F-0EBB-443B-B309-09C81844406E}": {
            "description": "Beltrano",
            "permissionGroups": [
                "{C188D1AB-EC28-4380-96E0-D1B13A29A8B3}"
            ]
        }
    }
 ```

 ## Utilizando no Delphi

 Você pode utilizar os recursos do proprio componente para criar seu arquivo de configuração ou criar manualmente e carrega-lo no componentes.

 ### Carregando um JSON já pronto

 ```delphi
 var
  aJson : TJsonObject;
begin
  aJson := TJSONObject.ParseJSONValue('SEU JSON') as TJsonObject;
  try
    TSafety4D.New.LoadConfig(aJson);
  finally
    aJson.Free;
  end;
 ```

 Uma vez estando com as configurações do arquivo carregadas no componente TSafety4D, você pode utilizar os recursos de validação.


 ### Validando o acesso a um recursos

 ```delphi
 TSafety4D.New
    .Validation
      .userKey('CHAVE DO USERKEY')
      .application('APPLICATION DO RECURSO')
      .resource('NOME DO RECURSOS')
      .action('ACTION A SER EXECUTADA')
    .validate;
 ``` 

 Abaixo o exemplo utilizando os dados do arquivo de configuração que mostramos acima, verificando se um usuário especifico possuí a permissão para escrever no recurso de <b>users</b>.

 ```delphi
  TSafety4D.New
    .Validation
      .userKey('{34C940ED-50E7-4CE3-B701-03CF1E15F28B}')
      .application('safety4d')
      .resource('users')
      .action('write')
    .validate;
 ```

O <b>Safety4D</b> trabalha com uma instancia Singleton, ou seja, a mesma instancia é compartilhada em toda a aplicação, com isso algumas configurações você pode deixar por default como por exemplo <b>userKey e application</b> que provavelmente não irão mudar em uma sessão de usuário durante o uso.

Sendo assim você pode por exemplo na instancia principal da sua aplicação já deixar esses valores setados.

```delphi
 TSafety4D.New
   .Validation
     .userKey('{34C940ED-50E7-4CE3-B701-03CF1E15F28B}')
     .application('safety4d');
```

E durante o uso nas demais telas você não precisa mais passar essas informações para realizar a validação de um recurso.

```delphi
TSafety4D.New
   .Validation
     .resource('users')
     .action('write')
   .validate;
```
### Exceptions

A função validade retorna um boolean sinalizando se o acesso é permitido ou não, porém você pode tratar a permissão fazendo com que o TSafety4D dispare uma excessão com a mensagem do que falhou na validação, não necessitando assim de estrutura condicional para validar o acesso.

```delphi
  TSafety4D.New
    .configurations
      .exceptions(True)
    .&end
    .Validation
      .userKey('{34C940ED-50E7-4CE3-B701-03CF1E15F28B}')
      .application('safety4d')
      .resource('users')
      .action('write')
    .validate;
 ```

## Definindo as Configurações pelo Sistema

Você pode criar o arquivo de configuração manualmente e carrega-lo no componente ou utilizar o proprio componente para definir as configurações.

```delphi
TSafety4D
  .New
    .resources
      .registerResources
        .resourcesGroupName
          .add('newapplication')
          .providerName
            .add('users')
            .actions
              .add('read')
                .description('read-only')
                .errormsg('not permit')
              .&end
              .add('write')
                .description('read-write')
                .errormsg('not write data')
              .&end
              .add('delete')
                .description('delete-data')
                .errormsg('not delete data')
              .&end
              .add('view')
                .description('view data')
                .errormsg('not view data')
              .&end
            .&end
          .&end
        .&end
      .&end
    .&end
    .groupPermission
      .groupRegister
        .add('Operador')
          .description('Funções de Operador do Sistema')
          .actions
            .add('users.view')
          .&end
          .notActions
            .add('*')
          .&end
        .&end
      .&end
      .userKey
        .registerUserKey
          .add('Fulano de Tal')
            .addPermission('{96B4C46F-0EBB-443B-B309-09C81844406E}')
          .&end
        .&end
      .&end;
```

### Transformando as configuração do Componente em Json

Utilizando o código abaixo você carrega toda a configuração do componentes para um TJsonObject.

```delphi
var
  aJsonSafety4D : TJsonObject;
begin
  aJsonSafety4D := TJSONObject.Create;
  try
    TSafety4D.New.getConfig(aJsonSafety4D);
    Memo1.Lines.Add(aJsonSafety4D.Format);
  finally
    aJsonSafety4D.Free;
  end;
```

### Salvando a configuração em um Arquivo no Disco

Você pode utilizar o recursos abaixo para salvar as configurações diretamente no disco.

```delphi
TSafety4D.New.SaveToStorage();
```

## Dica

Crie a estrutura e salve ela no seu banco de dados em um campo de texto e carregue toda vez que abrir a aplicação ou tiver alguma mudança nas configurações para o componente.