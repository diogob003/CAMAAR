# Entidade responsavel por relacionar um formulario a uma turma
class ClassForm < ApplicationRecord
  belongs_to :class_group
  belongs_to :form
end
