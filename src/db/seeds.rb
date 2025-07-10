# Reset all data
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

materias = []
materias << Materia.create!(nome: "Engenharia de Software", codigo: "CIC0210")
materias << Materia.create!(nome: "Banco de Dados", codigo: "CIC0304")
materias << Materia.create!(nome: "Redes de Computadores", codigo: "CIC0405")
materias << Materia.create!(nome: "Inteligência Artificial", codigo: "CIC0506")

turmas = []
materias.each do |mat|
  turmas << Turma.create!(materia: mat, numero: 1, semestre: "2025.1")
  turmas << Turma.create!(materia: mat, numero: 2, semestre: "2025.1")
end

professores = []
professores << Usuario.create!(nome: "Professor Um", matricula: "12345", email: "prof1@unb.br", cargo: "professor", senha_hash: "hash", senha_salt: "salt")
professores << Usuario.create!(nome: "Professor Dois", matricula: "23456", email: "prof2@unb.br", cargo: "professor", senha_hash: "hash", senha_salt: "salt")

(3..7).each do |i|
  professores << Usuario.create!(nome: "Professor #{i}", matricula: (23456+i).to_s, email: "prof#{i}@unb.br", cargo: "professor", senha_hash: "hash", senha_salt: "salt")
end

alunos = []
alunos << Usuario.create!(nome: "Aluno Um", matricula: "34567", email: "aluno1@unb.br", cargo: "aluno", senha_hash: "hash", senha_salt: "salt")
alunos << Usuario.create!(nome: "Aluno Dois", matricula: "45678", email: "aluno2@unb.br", cargo: "aluno", senha_hash: "hash", senha_salt: "salt")

(3..7).each do |i|
  alunos << Usuario.create!(nome: "Aluno #{i}", matricula: (45678+i).to_s, email: "aluno#{i}@unb.br", cargo: "aluno", senha_hash: "hash", senha_salt: "salt")
end

turmas.each_with_index do |turma, i|
  TurmaProfessor.create!(professor: professores[i % professores.size], turma: turma)
end

alunos.each_with_index do |aluno, i|
  TurmaAluno.create!(aluno: aluno, turma: turmas[i % turmas.size])
end

templates = professores.map do |prof|
  Template.create!(usuario_criador: prof, titulo: "Template de #{prof.nome}", descricao: "Template criado por #{prof.nome}")
end

formularios = []
10.times do |i|
  professor = professores[i % professores.size]
  template = templates[i % templates.size]
  form = Formulario.create!(
    usuario_publicador: professor,
    template: template,
    data_abertura: Date.today,
    data_fechamento: Date.today + rand(5..15)
  )
  turma = turmas[i % turmas.size]
  TurmaFormulario.create!(turma: turma, formulario: form)
  formularios << form
end

formularios.each_with_index do |form, i|
  pergunta = Pergunta.create!(template: form.template, titulo: "Pergunta #{i+1}", descricao: "Descrição da pergunta #{i+1}")

  if i.even?
    3.times do |j|
      Opcao.create!(pergunta: pergunta, descricao: "Opção #{j+1}", ordem: j+1)
    end
  end
end

alunos.each_with_index do |aluno, i|
  form_responded = formularios[i % formularios.size]
  FormularioRespondido.create!(usuario: aluno, formulario: form_responded)

  not_responded = (formularios - [form_responded]).sample
  puts "#{aluno.nome} has not responded to Formulario ID #{not_responded.id}"
end

formularios.each do |form|
  form.template.perguntas.each do |pergunta|
    if pergunta.opcoes.any?
      Resposta.create!(pergunta: pergunta, opcao: pergunta.opcoes.first, justificativa: "Justificativa exemplo.")
    else
      Resposta.create!(pergunta: pergunta, justificativa: "Resposta aberta exemplo.")
    end
  end
end

puts "Seed finalizado com sucesso!"
