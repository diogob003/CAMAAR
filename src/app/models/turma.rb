class Turma < ApplicationRecord
  belongs_to :materia

  has_many :turma_professores
  has_many :professors, through: :turma_professores, source: :professor

  has_many :turma_alunos
  has_many :alunos, through: :turma_alunos, source: :aluno

  has_many :turma_formularios
  has_many :formularios, through: :turma_formularios
end
