class Turma < ApplicationRecord
  has_and_belongs_to_many :professores, class_name: 'Usuario', join_table: :turma_professors
  has_and_belongs_to_many :alunos, class_name: 'Usuario', join_table: :turma_alunos
  has_and_belongs_to_many :formularios, join_table: :turma_formularios
end