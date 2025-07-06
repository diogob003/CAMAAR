class Formulario < ApplicationRecord
  has_and_belongs_to_many :turmas, join_table: :turma_formularios
  has_and_belongs_to_many :usuarios, join_table: :formularios_respondidos
end
