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

Ele se baseia em uma estrutura JSON de configuração para definição das permissões.

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


