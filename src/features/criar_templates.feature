# language: pt

Funcionalidade: Criação de templates

  Como administrador
  Quero criar novos templates
  Para gerar formulários de avaliação

  Cenário: Criação de novo template
    Dado que estou logado como administrador
    E estou na página "Gerenciamento" de templates
    E cliquei em "+" para criar template
    E fui para a página de criação de template
    E adicionei uma nova questão
    Quando clicar em "Criar"
    Então o template será criado com sucesso

  Cenário: Criação de template em branco
    Dado que estou logado como administrador
    E estou na página "Gerenciamento" de templates
    E cliquei em "+" para criar template
    E fui para a página de criação de template
    Quando clicar em "Criar"
    Então deverá aparecer uma mensagem de erro
