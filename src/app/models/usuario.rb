class Usuario < ApplicationRecord
  has_many :turma_professors, foreign_key: :professor_id
  has_many :turmas_as_professor, through: :turma_professors, source: :turma

  has_many :turma_alunos, foreign_key: :aluno_id
  has_many :turmas_as_aluno, through: :turma_alunos, source: :turma

  has_many :formularios_publicados, class_name: 'Formulario', foreign_key: :id_usuario_publicador
  has_many :templates_criados, class_name: 'Template', foreign_key: :id_usuario_criador

  has_many :formularios_respondidos
end
