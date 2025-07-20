# language: pt

Funcionalidade: Gerenciamento de templates de formulários

  Como administrador
  Quero editar e/ou deletar um template que eu creiei sem afetar os formulários já criados
  Para organizar os templates existentes

  Cenário: Editar um template existente
    Dado que estou logado como administrador
    E tenho templates de formulários disponíveis
    E estou na página de gerenciamento de templates
    Quando clico no card do template
    E altero o nome do template
    E clico em editar
    Então o template deve ter o nome alterado

  Cenário: Deletar um template existente
    Dado que estou logado como administrador
    E tenho templates de formulários disponíveis
    E estou na página de gerenciamento de templates
    Quando clico na opção "Deletar" do template
    Então o template deve ser removido da lista de templates disponíveis
