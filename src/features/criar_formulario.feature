# language: pt

Funcionalidade: Criação de formulários baseados em template

  Como administrador
  Quero criar um formulário baseado em um template para as turmas selecionadas
  Para avaliar o desempenho das turmas no semestre atual

  Cenário: Criar formulário para turma selecionada
    Dado que estou logado como administrador
    E tenho templates de formulários disponíveis
    E sou professor de uma turma
    E estou na página de criação de formulários
    E escolhi um template no formulario
    E escolhi uma turma no formulario
    Quando clicar em "Enviar"
    Então deve aparecer uma mensagem de sucesso
    E aparecer na página "Avaliações"

  Cenário: Duplicação de formulário para mesma turma
    Dado que estou logado como administrador
    E tenho templates de formulários disponíveis
    E sou professor de uma turma
    E estou na página de criação de formulários
    E escolhi um template no formulario
    E escolhi uma turma no formulario
    E ja existe um formulário com aquele template para aquela turma
    Quando clicar em "Enviar"
    Então uma mensagem de alerta deve aparecer indicando que a turma já possui aquele formulário
