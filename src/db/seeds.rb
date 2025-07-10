# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

Resposta.delete_all
Opcao.delete_all
Pergunta.delete_all
FormularioRespondido.delete_all
TurmaFormulario.delete_all
Formulario.delete_all
Template.delete_all
TurmaAluno.delete_all
TurmaProfessor.delete_all
Turma.delete_all
Materia.delete_all
Usuario.delete_all

puts "Seed iniciado..."

mat1 = Materia.create!(nome: "Engenharia de Software", codigo: "CIC0210")
mat2 = Materia.create!(nome: "Banco de Dados", codigo: "CIC0304")

prof1 = Usuario.create!(nome: "Professor Um", matricula: "12345", email: "prof1@unb.br", cargo: "professor", senha_hash: "hash", senha_salt: "salt")
prof2 = Usuario.create!(nome: "Professor Dois", matricula: "23456", email: "prof2@unb.br", cargo: "professor", senha_hash: "hash", senha_salt: "salt")

aluno1 = Usuario.create!(nome: "Aluno Um", matricula: "34567", email: "aluno1@unb.br", cargo: "aluno", senha_hash: "hash", senha_salt: "salt")
aluno2 = Usuario.create!(nome: "Aluno Dois", matricula: "45678", email: "aluno2@unb.br", cargo: "aluno", senha_hash: "hash", senha_salt: "salt")

turma1 = Turma.create!(materia: mat1, numero: 1, semestre: "2025.1")
turma2 = Turma.create!(materia: mat2, numero: 2, semestre: "2025.1")

TurmaProfessor.create!(professor: prof1, turma: turma1)
TurmaProfessor.create!(professor: prof2, turma: turma2)

TurmaAluno.create!(aluno: aluno1, turma: turma1)
TurmaAluno.create!(aluno: aluno2, turma: turma2)

template1 = Template.create!(usuario_criador: prof1, titulo: "Template Avaliação Intermediária", descricao: "Template para prova intermediária")
template2 = Template.create!(usuario_criador: prof2, titulo: "Template Avaliação Final", descricao: "Template para prova final")

form1 = Formulario.create!(usuario_publicador: prof1, template: template1, data_abertura: Date.today, data_fechamento: Date.today + 7)
form2 = Formulario.create!(usuario_publicador: prof2, template: template2, data_abertura: Date.today, data_fechamento: Date.today + 7)

TurmaFormulario.create!(turma: turma1, formulario: form1)
TurmaFormulario.create!(turma: turma2, formulario: form2)

pergunta1 = Pergunta.create!(template: template1, titulo: "Como avalia o conteúdo?", descricao: "Avaliação do conteúdo ministrado.")
pergunta2 = Pergunta.create!(template: template1, titulo: "Sugestões para melhorar?", descricao: "Espaço aberto para sugestões.")

opcao1 = Opcao.create!(pergunta: pergunta1, descricao: "Excelente", ordem: 1)
opcao2 = Opcao.create!(pergunta: pergunta1, descricao: "Bom", ordem: 2)
opcao3 = Opcao.create!(pergunta: pergunta1, descricao: "Regular", ordem: 3)
opcao4 = Opcao.create!(pergunta: pergunta1, descricao: "Ruim", ordem: 4)

FormularioRespondido.create!(usuario: aluno1, formulario: form1)
FormularioRespondido.create!(usuario: aluno2, formulario: form2)

Resposta.create!(pergunta: pergunta1, opcao: opcao1, justificativa: "Conteúdo muito bem explicado.")
Resposta.create!(pergunta: pergunta2, justificativa: "Gostaria de mais exemplos práticos.")

puts "Seed finalizado com sucesso!"
