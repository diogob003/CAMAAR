# language: pt

Funcionalidade: Visualização do resultado de formulários

  Como Administrador
  Quero visualizar os formulários que foram criados
  Para poder gerar relatório a partir de respostas coletadas

  Cenário: Listando formulários criados para baixar os resultados
    Dado que estou logado como administrador
    E eu criei um formulario para uma de minhas turmas
    E estou na página "Gerenciamento"
    Quando clicar em "Resultados"
    E estiver na página de resultados
    Então devo ver uma grade com o formulário disponível

  Cenário: Zero formulários na página de resultados
    Dado que estou logado como administrador
    E nao criei nenhum formulario
    E estou na página "Gerenciamento"
    Quando clicar em "Resultados"
    Então a grade de resultados deve estar vazia
