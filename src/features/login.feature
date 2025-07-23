# language: pt

Funcionalidade: Acesso ao sistema por login

  Como Usuário do Sistema
  Quero acessar o sistema utilizando um e-mail ou matrícula e uma senha já cadastrada
  Para responder formulários ou gerenciar o sistema

  Cenário: Login com e-mail e senha de aluno válidos
    Dado que existe um aluno cadastrado
    E que estou na página de login
    E preenchi com email e senha válidos
    Quando clico em "Entrar"
    Então devo ser redirecionado para a página inicial
    E ver um aviso de sucesso de login
    E nao ter acesso ao menu de gerenciamento

  Cenário: Login com matrícula e senha de aluno válidos
    Dado que existe um aluno cadastrado
    E que estou na página de login
    E preenchi com matrícula e senha válidos
    Quando clico em "Entrar"
    Então devo ser redirecionado para a página inicial
    E ver um aviso de sucesso de login
    E nao ter acesso ao menu de gerenciamento

  Cenário: Login como administrador
    Dado que existe um administrador cadastrado
    E que estou na página de login
    Quando coloco as credenciais de administrador
    E clico em "Entrar"
    Então devo ver a opção de gerenciamento no menu lateral

  Cenário: Login com dados inválidos
    Dado que existe um aluno cadastrado
    E que estou na página de login
    E preenchi um e-mail, matrícula ou senha incorretos
    Quando clico em "Entrar"
    Então devo ver uma mensagem de credenciais inválidas
