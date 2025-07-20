# language: pt

Funcionalidade: Exportação de resultados de formulários

  Como administrador
  Quero baixar um arquivo CSV contendo os resultados de um formulário
  Para avaliar o desempenho das turmas

  Cenário: Baixar arquivo CSV contendo resultados do formulário
    Dado que estou logado como administrador
    E eu criei um formulario para uma de minhas turmas
    E estou na pagina de resultados
    Quando Clicar no botão de baixar o csv
    Então os resultados devem ser baixado em CSV
