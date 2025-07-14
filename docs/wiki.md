## Wiki

- DIOGO BORGES SILVA 232035914
- ALAN MAGALHAES FLORENCIO 221037376
- PEDRO HENRIQUE SOUZA DOS SANTOS 202037604
- THIAGO VERAS RODRIGUES QUEIROZ 211055370
- MAXWELL OLIVEIRA DOS REIS 221002100

O repositório está presente no seguinte [link](https://github.com/diogob003/CAMAAR)

O esquema de branch utilizado será de uma branch por feature. Ou seja, haverá uma branch para trabalhar na autenticação, outra para a visualização de formulários e etc. Algumas branchs tem o nome no formato "CAM-3" ou "CAM-19", esse nome representa CAM = CAMAAR e o numero representa o número da issue correspondende no repositório. 


### Sprint 1

As definições dos primeiros papéis foram as seguintes

- Product Owner Pedro
- Scrum Master Alan

Além disso, nessa primeira sprint, definimos as funcionalidades, cenários e perguntas no modelo BDD. Os resultados podem ser encontrados na pasta na pasta bdd [repositório](https://github.com/diogob003/CAMAAR/tree/main)

### Sprint 2

Nessa sprint tivemos avanços na implementação do sistema. Foi possível desenhar todo o layout do sistema, incluindo a página de administração, resposta de formulários, admin e etc, seguindo fielmente o design do figma dado. Além disso, já é possível autenticar no sistema por meio de email ou matrícula, visualizar os formulários disponíveis para suas turmas, visualizar suas perguntas e respondê-lo. Seguinte a numeração das issues originais, segue a lista das features implementadas:

- Autenticação por matricula ou email (Diogo)
- Listagem de formulários (Maxwell)
- Visualização / submissão de respostas de um formulário (Maxwell)

Note que, para todas as features citadas, há testes BDD também implementados usando o cucumber. Os arquivos .feature já estão disponíveis para todas as issues, mas alguns ainda não foram realmente implementados. Sendo assim, recomenda-se executar o cucumber com o seguinte comando

> bundle exec cucumber --tags "not @ignore" --publish-quiet

De modo a ignorar os testes ainda implementados e rodar apenas os cenários existentes.

A branch criada para essa sprint se chama "sprint-2" e é dela que faremos o pull-request no repositório original.