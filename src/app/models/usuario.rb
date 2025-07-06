class Usuario < ApplicationRecord
  has_and_belongs_to_many :turmas_como_professor, class_name: 'Turma', join_table: :turma_professors
  has_and_belongs_to_many :turmas_como_aluno, class_name: 'Turma', join_table: :turma_alunos
  has_and_belongs_to_many :formularios, join_table: :formularios_respondidos
end