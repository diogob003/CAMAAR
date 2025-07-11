class Usuario < ApplicationRecord
  has_many :turma_professores, foreign_key: :professor_id
  has_many :turmas_as_professor, through: :turma_professores, source: :turma

  has_many :turma_alunos, foreign_key: :aluno_id
  has_many :turmas_as_aluno, through: :turma_alunos, source: :turma

  has_many :templates_criados, class_name: 'Template', foreign_key: :usuario_criador_id

  has_many :formularios_publicados, class_name: 'Formulario', foreign_key: :usuario_publicador_id

  has_many :formularios_respondidos
  has_many :formularios, through: :formularios_respondidos
end
