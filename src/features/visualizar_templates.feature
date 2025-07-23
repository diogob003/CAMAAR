# language: pt

Funcionalidade: Visualização de templates criados

  Como Administrador
  Quero visualizar todos os templates criados
  Para poder editar e/ou deletar um template que eu criei

  Cenário: Listar templates criados
    Dado que estou logado como administrador
    E tenho templates de formulários disponíveis
    E estou na página de gerenciamento de templates
    Então devo ver uma grade com todos os templates criados

  Cenário: Deletar um template
    Dado que estou logado como administrador
    E tenho templates de formulários disponíveis
    E estou na página de gerenciamento de templates
    Quando clicar em deletar template
    Então a tela deverá atualizar para não mostrar ele