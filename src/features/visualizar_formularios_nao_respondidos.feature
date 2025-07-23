# language: pt

Funcionalidade: Visualização de formulários não respondidos

  Como participante de uma turma
  Quero visualizar todos os formulários de uma turma em que estou matriculado
  Para poder escolher qual irei responder

  Cenário: Exibir lista de formulários
    Dado que estou logado como estudante
    E estou matriculado em uma turma
    E existe um formulário de avaliação para essa turma
    Quando acesso a página "Avaliações"
    Então devo ver uma grade com todos os formulários
    E cada formulário deve mostrar o nome da disciplina, semestre e nome do professor

  Cenário: Formulário respondido visualmente diferente
    Dado que estou logado como estudante
    E estou matriculado em uma turma
    E existe um formulário de avaliação para essa turma
    E eu já respondi esse formulário
    Quando acesso a página "Avaliações"
    Então o formulário está marcado como respondido
