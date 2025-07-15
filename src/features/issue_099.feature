# language: pt

Funcionalidade: Responder formulário

  Como participante de uma turma
  Quero responder o questionário sobre uma turma em que estou matriculado
  Para submeter minha avaliação da turma

  Cenario: Redirecionamento para página de respostas do formulário
    Dado que estou logado como estudante
    E existe um formulario para uma de minhas turmas
    Quando acesso a página "Avaliações"
    E clico nesse formulário
    Entao devo ser redirecionado para a página de submissao de respostas do formulário

  Cenario: Cancelamento de resposta
    Dado que estou logado como estudante
    E existe um formulario para uma de minhas turmas
    Quando acesso a página "Avaliações"
    E clico nesse formulário
    E vou para a página de submissao de respostas do formulário
    E volto para página de "Avaliações"
    Entao o formulário deve continuar como não respondido

  Cenario: Responder um formulario
    Dado que estou logado como estudante
    E existe um formulario para uma de minhas turmas
    Quando acesso a página "Avaliações"
    E clico nesse formulário
    E vou para a página de submissao de respostas do formulário
    E respondo a pergunta com o texto "Gostei da disciplina"
    E faço a submissao
    Então volto para página de "Avaliações"
    E o formulário está marcado como respondido
